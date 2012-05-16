source :rubygems

gem 'rails', '3.2.3'
gem 'pg'

gem 'omniauth', '1.1.0'
gem 'omniauth-vkontakte'
gem 'devise', '2.1.0'

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

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'faker'
  gem 'factory_girl_rails'
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
