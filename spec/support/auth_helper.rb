module AuthHelper
  def http_login
    user = ENV['PERFUSER']
    pass = ENV['PERFPASS']
    header 'Authorization', ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
  end
end
