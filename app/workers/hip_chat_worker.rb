class HipChatWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform commit_info, score_result, color, comparison_url
    HipChatNotifier.new({
                          commit_info: commit_info,
                          score_result: score_result,
                          color: color,
                          comparison_url: comparison_url
                        }).send
  end
end
