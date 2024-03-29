require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

ENV.update YAML.load_file("#{Rails.root}config/allscripts.yml")[Rails.env]

module Additiveanalytics
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    require 'rack/reverse_proxy'

    config.middleware.use Rack::ReverseProxy do
      reverse_proxy_options preserve_host: true
      reverse_proxy((/^\/blog(\/.*)$/), 'http://blog.additiveanalytics.com/blog$1')
    end

    require 'rack/cors'
    config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
      allow do
        origins '*'
        # location of your API
        resource '/api_sessions', :headers => :any, :methods => [:get, :post, :options, :put]
        resource '/api/*', :headers => :any, :methods => [:get, :post, :options, :put]
        resource '/api/schedule_app_api', :headers => :any, :methods => [:get, :post, :options, :put]
        end
    end

    # Don't want rails-api to break our application
    config.api_only = false
  end
end
