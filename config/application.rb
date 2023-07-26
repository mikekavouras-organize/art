require_relative 'boot'

require 'rails/all'
require "view_component"
require "primer/view_components/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Art
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.active_record.legacy_connection_handling = false
    config.load_defaults 7.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
