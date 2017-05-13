require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kpt
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.time_zone = 'Tokyo'

    I18n.enforce_available_locales = true
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # config.autoload_paths += %W(#{config.root}/lib)
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]

    Slim::Engine.set_options pretty: false

    config.generators do |g|
      g.assets false
      g.helper false
      g.view false

      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false
      g.fixture_replacement :factory_girl,
                            dir: 'spec/factories'
    end

    config.action_mailer.default_url_options = { host: ENV['MY_HOST'] }
    config.action_mailer.smtp_settings = {
      user_name: ENV['SENDGRID_USER_NAME'],
      password: ENV['SENDGRID_USER_PASSWORD'],
      domain: ENV['SENDGRID_DOMAIN'],
      address: 'smtp.sendgrid.net',
      port: 587,
      authentication: :plain,
      enable_starttls_auto: true,
    }
  end
end
