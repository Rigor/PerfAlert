require 'swagger_client'
require_relative 'slack_worker.rb'

class OptimizationWorker
  include Sidekiq::Worker
  # no retries to avoid creating more snapshots on failure
  sidekiq_options :retry => false

  OPTIMIZATION_TEST_ID = ENV['OPTIMIZATION_TEST_ID'].freeze

  def perform commit
    client = SwaggerClient::SnapshotsApi.new(SwaggerClient::ApiClient.new)
    snapshot        = client.v2_snapshots_post(OPTIMIZATION_TEST_ID, {})
    new_snapshot_id = snapshot.snapshot_id

    # poll for snapshot completion
    tries = 0
    snapshot_in_progress = true
    while snapshot_in_progress
      new_snapshot = client.v2_snapshots_get_1(OPTIMIZATION_TEST_ID, new_snapshot_id)
      puts "Snapshot status: #{new_snapshot.status}"
      tries += 1
      if new_snapshot.status == 'Complete'
        puts "Snapshot complete"
        snapshot_in_progress = false
      elsif tries > 10
        raise "Snapshot took a while, calling it quits"
      elsif ['InQueue', 'ScanRunning'].include?(new_snapshot.status)
        sleep_time = 30
        puts "Sleeping for #{sleep_time} seconds, then polling snapshot status for snapshot #{new_snapshot_id}"
        sleep sleep_time
      else # not complete, in queue, or running
        raise "Snapshot creation failed"
      end
    end

    snapshots        = client.v2_snapshots_get(OPTIMIZATION_TEST_ID, p_order_by: 'ScanAddedUTC', p_per_page: 2).snapshots
    new_snapshot     = snapshots.first
    new_defect_count = new_snapshot.defect_count_total_1pc + new_snapshot.defect_count_total_3pc
    old_snapshot     = snapshots.last
    old_defect_count = old_snapshot.defect_count_total_1pc + old_snapshot.defect_count_total_3pc

    comparison_url   = optimization_compare_url(old_snapshot.snapshot_id, new_snapshot.snapshot_id)

    defect_count_result, result = make_defect_count_and_result(new_defect_count, old_defect_count)
    SlackWorker.perform_async(commit, defect_count_result, "ColorHelper::#{result}::HEX".constantize, comparison_url)
    HipChatWorker.perform_async(commit, defect_count_result, "ColorHelper::#{result}::SIMPLE".constantize, comparison_url)
  end

  private

  def make_defect_count_and_result(new_defect_count, old_defect_count)
    if new_defect_count > old_defect_count
      ["Total defect count increased from #{old_defect_count} to #{new_defect_count}", 'Failure']
    elsif new_defect_count < old_defect_count
      ["Total defect count decreased from #{old_defect_count} to #{new_defect_count}", 'Success']
    else
      ["Total defect count remained the same", 'Success']
    end
  end

  def optimization_compare_url old_snapshot, new_snapshot
    "https://optimization.rigor.com/c/#{old_snapshot}/#{new_snapshot}"
  end
end
