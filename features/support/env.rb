require 'rubygems'
require 'spork'
require 'spork/ext/ruby-debug'

Spork.prefork do
  require 'cucumber'
  require 'cucumber/rails'
  require 'cucumber/rails/world'
  require 'factory_girl/step_definitions'

  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :transaction

  SUPPORT_DIR = Rails.root.join('features/support')
end

Spork.each_run do
  # # Some misc
  Capybara.reset_sessions!    # Forget the (simulated) browser state
  Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver

  Before do
    DatabaseCleaner.start
    if Spork.using_spork?
      Dir["#{Rails.root}/app/models/**/*.rb"].each{|f| load f}
      Dir[Rails.root.join('features/support/**/*.rb')].each{|f| load f}
      BrightPeople::Application.reload_routes!
      FactoryGirl.reload
    end
  end

  After do
    DatabaseCleaner.clean
  end
end
