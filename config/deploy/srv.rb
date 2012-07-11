set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :branch, "master"

load 'config/deploy/srv_avg'

before "deploy:update_code", "backup:create"
before "bundle:install", "deploy:remove_assets_folder"

before "deploy:assets:precompile", "deploy:migrate"
after "deploy:migrate", "thinking_sphinx:configure"

after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"

before "deploy:restart", "unicorn:stop"
