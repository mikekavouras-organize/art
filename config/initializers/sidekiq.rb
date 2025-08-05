if ENV["REDIS_URL"]&.start_with?("rediss://")
  ssl_opts = { verify_mode: OpenSSL::SSL::VERIFY_NONE }
else
  ssl_opts = {}
end

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL", "redis://localhost:6379"),
    ssl_params: ssl_opts
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL", "redis://localhost:6379"),
    ssl_params: ssl_opts
  }
end
