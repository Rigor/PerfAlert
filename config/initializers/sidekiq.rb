require 'sidekiq'

Sidekiq.configure_client do |c|
  c.redis = { size: 1 }
end

Sidekiq.configure_server do |c|
  c.redis = { size: 4 }
end
