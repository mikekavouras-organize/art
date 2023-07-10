require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Art
  class Application < Rails::Application
    config.load_defaults 6.0
    config.active_record.legacy_connection_handling = false
    config.load_defaults 7.0
  end
end
