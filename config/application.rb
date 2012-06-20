require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module BrightPeople
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/extras)
    config.active_record.observers = [:activity_vote_observer, :contest_vote_observer, :article_observer]
    config.i18n.default_locale = :ru
    config.i18n.locale = :ru
    config.encoding = 'utf-8'
    config.filter_parameters += [:password]
    config.active_record.whitelist_attributes = true
    config.assets.enabled = true
    config.assets.version = '1.0'

    # Special for ltree
    config.active_record.schema_format = :sql

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.stylesheets false
    end

  end
end
