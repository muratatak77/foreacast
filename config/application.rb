require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Forecast2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.autoload_paths += ["#{Rails.root}/lib", "#{Rails.root}/app"]
    config.eager_load_paths << "#{Rails.root}/lib"
    config.generators.test_framework = false
    
    config.quiet_assets = true
    redis_uri = URI.parse(ENV.fetch("REDISCLOUD_URL", "redis://127.0.0.1:6379"))
    redish_hash = {
        host: redis_uri.host,
        port: redis_uri.port,
        db: 0
        # namespace: 'unicobag_rails_cache'
    }
    redish_hash[:user] = redis_uri.user if redis_uri.user.present?
    redish_hash[:password] = redis_uri.password if redis_uri.password.present?
    config.cache_store = :redis_store, redish_hash, { expires_in: 30.minutes}

  end
end
