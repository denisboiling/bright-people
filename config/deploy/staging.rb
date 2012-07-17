role :web, "stagebp.balticit.ru"
role :app, "stagebp.balticit.ru"
role :db,  "stagebp.balticit.ru", :primary=>true

set :user, 'www-data'
set :deploy_via, :remote_cache
set :use_sudo, false

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-1.9.3-p194-perf@bright-people'
require "rvm/capistrano"

set :deploy_to, "/var/www/#{application}-stage"
set :rails_env, "production"
set :branch, "stage"

load 'config/deploy/avg'

set :keep_releases, 5
after "deploy:restart","deploy:cleanup"

before "bundle:install", "deploy:remove_assets_folder"
before "deploy:finalize_update", "shared:symlinks"

after "deploy:update_code", "unicorn:stop"
after "deploy:update_code", "thinking_sphinx:stop"
after "deploy:update_code", "delayed_job:stop"

after "deploy:update_code", "staging:load_db"
after "staging:load_db", "deploy:migrate"
after "deploy:update_code", "staging:load_images"

after "deploy:update_code", "thinking_sphinx:configure"
after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"
