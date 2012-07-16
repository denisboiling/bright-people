role :web, "bender.srv.balticit.ru"
role :app, "bender.srv.balticit.ru"
role :db,  "bender.srv.balticit.ru", :primary=>true

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

before "bundle:install", "deploy:remove_assets_folder"
before "deploy:finalize_update", "shared:symlinks"

if ENV['new']
  before "db:prepare", "unicorn:stop"
  before "db:prepare", "thinking_sphinx:stop"
  before "db:prepare", "delayed_job:stop"
  after "deploy:finalize_update", "main_site"
  after "main_site", "deploy:migrate"
else
  before "deploy:assets:precompile", "deploy:migrate"
end

after "deploy:migrate", "thinking_sphinx:configure"
after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"
before "deploy:restart", "unicorn:stop"
