source :rubygems

gem 'rails', '3.2.3'
gem 'pg'

gem 'omniauth', '1.1.0'
gem 'omniauth-vkontakte'
gem 'omniauth-facebook'
gem 'omniauth-odnoklassniki'
gem 'devise', '2.1.0'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'jquery-ui-themes'
gem 'unicorn'
gem 'activeadmin'
gem 'cancan'
gem 'spatial_adapter'
gem 'russian'

group :development do
  gem 'letter_opener'
end

group :test do
  gem 'cucumber-rails'
end

group :development, :test do
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
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
