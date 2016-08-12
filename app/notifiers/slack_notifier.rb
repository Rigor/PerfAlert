class SlackNotifier
  ATTRIBUTES = %I(commit score_result color comparison_url)

  attr_reader(*ATTRIBUTES)

  DEFAULTS = {
    commit: {
      'id' => 'No commit ID given',
      'url' => 'https://github.com/Rigor/PerfAlert/blob/master/README.md',
      'author_name' => 'No author given'
    },
    score_result: 'No score result given',
    color: '#C0392B',
    comparison_url: 'https://github.com/Rigor/PerfAlert/blob/master/README.md'
  }

  
  def initialize(opts = {})
    DEFAULTS.
      merge(opts).
      slice(*ATTRIBUTES).
      each { |k,v| instance_variable_set("@#{k}", v) }

    @client = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], http_options: { open_timeout: 10 }).
              tap { |notifier| notifier.username = 'Rigor Optimization' }
  end

  def send
    @client.ping(nil, attachments: [ attachments ])
  end

  def attachments
    {
      title:      score_result,
      title_link: comparison_url,
      color:      color,
      fields: [
        {
          title: 'Commit',
          value: "<#{commit['url']} | #{commit['id']}>",
          short: true
        },
        {
          title: 'Author',
          value: commit['author_name'],
          short: true
        }
      ],
      fallback: "#{score_result}: #{comparison_url}"
    }
  end
end
