set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"

load 'config/deploy/srv_avg'
