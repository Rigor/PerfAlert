module RequestHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end
