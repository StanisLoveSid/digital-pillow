require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookStore
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

  require 'privatbank'

  Privatbank.configure do |config|
    config.merchant_id = '130045'
    config.merchant_password = 'hSRqf5avJiUErr99NQq3BoRbq1wIFsNS'
  end
 
  config.active_job.queue_adapter = :sidekiq
  config.i18n.available_locales = [:ua]
  config.i18n.default_locale = :ua

  ActionMailer::Base.smtp_settings = {
   :address        => 'smtp.gmail.com',
   :domain         => 'mail.google.com',
   :port           => 587,
   :user_name      => 'forumjankenpon@gmail.com',
   :password       => '301095st',
   :authentication => :plain,
   :enable_starttls_auto => true
    }    
  end
end
