class SlackWorker
  include Sidekiq::Worker

  def perform commit_info, score_result, color, comparison_url
    SlackNotifier.new({
                          commit_info:    commit_info,
                          score_result:   score_result,
                          color:          color,
                          comparison_url: comparison_url
                       }).send
  end

end
