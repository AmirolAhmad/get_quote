require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GetQuote
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Etc/UTC'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    config.encoding = "utf-8"
    config.active_record.raise_in_transactional_callbacks = true
  end
end
