role :web, "5.9.50.131"
role :app, "5.9.50.131"
role :db,  "5.9.50.131", :primary=>true

set :user, "rvm_user"
set :deploy_via, :remote_cache
set :use_sudo, false

set :rvm_type, :user
set :rvm_ruby_string, "ruby-1.9.3-head"
require "rvm/capistrano"

set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :branch, "master"

set :keep_releases, 30

after "deploy:restart","deploy:cleanup"

load 'config/deploy/avg'

before "deploy:finalize_update", "shared:symlinks"

before "deploy:assets:precompile", "deploy:migrate"

after "deploy:migrate", "thinking_sphinx:configure"
after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"
