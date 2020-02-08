require 'sidekiq'

# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://localhost:6379/0'  }
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://localhost:6379/0' }
# end

# for docker
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL']  }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL']  }
end
