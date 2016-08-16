require 'vcr'

# vcr configuration. vcr is used to replay HTTP repsonses as a way of stubbing requests. This is used
# in tandem with webmock to ensure that any external API testing is contained locally with stored reponses
VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<HIPCHAT_AUTH>') { ENV['HIPCHAT_API_KEY'] }
  c.filter_sensitive_data('<HIPCHAT_ROOM>') { ENV['HIPCHAT_ROOM_ID'] }
  c.filter_sensitive_data('<SLACK_WEBHOOK_URL>') { ENV['SLACK_WEBHOOK_URL'] }
end
