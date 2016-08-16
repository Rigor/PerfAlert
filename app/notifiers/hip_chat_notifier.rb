class HipChatNotifier
  ATTRIBUTES = %I(commit score_result color comparison_url)

  attr_reader(*ATTRIBUTES)

  DEFAULTS = {
    commit: {
      'id' => 'No commit ID given',
      'url' => 'https://github.com/Rigor/PerfAlert/blob/master/README.md',
      'author_name' => 'No author given'
    },
    score_result: 'No score result given',
    color: 'red',
    comparison_url: 'https://github.com/Rigor/PerfAlert/blob/master/README.md'
  }

  def initialize(opts = {})
    DEFAULTS.
      merge(opts).
      slice(*ATTRIBUTES).
      each { |k,v| instance_variable_set("@#{k}", v) }
  end

  def send
    HTTParty.post(url,
                  body: {
                    message:  score_result,
                    card:     create_card,
                    color:    color
                  }.to_json,
                  headers: headers)
  end

  private

  def create_card
    icon_url ? card.merge(icon: { url: icon_url }, id: generate_id(card)) : card.merge(id: generate_id(card))
  end

  def card
    {
      'style'  => 'application',
      'format' => 'compact',
      'url'    => comparison_url,
      'title'  => score_result,
      'attributes' => [
        {
          'label' => 'commit',
          'value' => {
            'label' => commit['id'],
            'url'   => commit['url']
          }
        },
        {
          'label' => 'Author',
          'value' => {
            'label' => commit['author_name']
          }
        }
      ],
    }
  end

  def url
    "https://www.hipchat.com/v2/room/#{ENV['HIPCHAT_ROOM_ID']}/notification?auth_token=#{ENV['HIPCHAT_API_KEY']}"
  end

  def generate_id(obj)
    Digest::MD5.hexdigest(obj.inspect)
  end

  def icon_url
    ENV['ICON_URL']
  end

  def headers
    {'Content-Type' => 'application/json'}
  end
end
