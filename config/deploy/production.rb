role :web, "bright-people.ru"
role :app, "bright-people.ru"
role :db,  "bright-people.ru", :primary => true

set :user, "rvm_user"
set :deploy_via, :remote_cache
set :use_sudo, false

set :rvm_type, :system
require "rvm/capistrano"

set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :branch, "master"

set :keep_releases, 30
set :delayed_workers, 1

after "deploy:restart","deploy:cleanup"

load 'config/deploy/avg'

before "bundle:install", "deploy:remove_assets_folder"
before "deploy:finalize_update", "shared:symlinks"

before "deploy:assets:precompile", "deploy:migrate"

after "deploy:migrate", "thinking_sphinx:configure"
after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"

before "unicorn:reload", "unicorn:stop"
