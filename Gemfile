source :rubygems

gem 'rails', '3.2.3'
gem 'pg'

gem 'omniauth', '1.1.0'
gem 'omniauth-vkontakte'
gem 'omniauth-facebook'
gem 'omniauth-odnoklassniki'
gem 'devise', '2.1.0'
gem 'acts-as-taggable-on'

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
gem 'paperclip'

# Because this need for samples
gem 'ffaker'

gem 'thinking-sphinx'
gem 'cocoon'
gem 'rails3-jquery-autocomplete'
gem 'hierarchy', github: 'RISCfuture/hierarchy'
gem 'kaminari'

group :development do
  gem 'letter_opener'
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano-unicorn'
  gem 'rvm-capistrano'
  gem 'sextant'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'cucumber-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'spork', github: 'sporkrb/spork'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'database_cleaner'
  unless ENV['JENKINS']
    gem 'thin'
    gem 'launchy'
    gem 'debugger'
  else
    gem 'headless'
  end
end
