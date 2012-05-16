require 'rubygems'
require 'spork'
require 'spork/ext/ruby-debug' unless ENV['JENKINS']

if Spork.using_spork?
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
  ActiveSupport::Dependencies.mechanism = :load
end

Spork.prefork do
  require 'cucumber'
  require 'cucumber/rails'
  require 'cucumber/rails/world'
  require 'factory_girl/step_definitions'
  require 'email_spec/cucumber'

  Cucumber::Rails::World.use_transactional_fixtures = false

  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :truncation

  SUPPORT_DIR = Rails.root.join('features/support')

  # For jenkins
  if ENV['JENKINS']
    require 'headless'
    headless = Headless.new
    headless.start
    at_exit do
      headless.destroy
    end
  end

  Cucumber::Rails::Database.javascript_strategy = :truncation
  Capybara.default_selector = :css
  ActionController::Base.allow_rescue = false

end

Spork.each_run do
  # Reload routes
  BrightPeople::Application.reload_routes!

  # reload factories
  FactoryGirl.reload

  # Some misc
  Capybara.reset_sessions!    # Forget the (simulated) browser state
  Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  Dir[Rails.root.join('features/support/**/*.rb')].each{|f| load f}

  # Reload models
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end

  Before do
    DatabaseCleaner.start
  end

  After do
    DatabaseCleaner.clean
  end
end
