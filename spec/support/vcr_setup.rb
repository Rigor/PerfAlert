require 'vcr'

# vcr configuration. vcr is used to replay HTTP repsonses as a way of stubbing requests. This is used
# in tandem with webmock to ensure that any external API testing is contained locally with stored reponses
VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
