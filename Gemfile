source :rubygems

gem 'rails', '3.2.3'
gem 'pg'
gem 'devise', '2.0.4'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'unicorn'

group :development do
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'quiet_assets'
  gem 'database_cleaner'
  unless ENV['JENKINS']
    gem 'thin'
    gem 'launchy'
    gem 'debugger'
  else
    gem 'headless'
  end
end
