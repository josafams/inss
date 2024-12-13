Sidekiq.configure_server do |config|
    config.redis = { url: ENV['SIDEKIQ_REDIS_URL'] }
end
  
Sidekiq.configure_client do |config|
    config.redis = { url: ENV['SIDEKIQ_REDIS_URL'] }
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
                                                ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USER'])) &&
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
                                                  ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
end
  