require_relative "boot"
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HanaNavApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # 日本語化
    config.i18n.default_locale = :ja
    # タイムゾーンも変更
    config.time_zone = 'Asia/Tokyo'
    #slimに変更
    config.generators.template_engine = :slim
  end
end
