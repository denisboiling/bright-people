set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :branch, "master"

load 'config/deploy/srv_avg'
