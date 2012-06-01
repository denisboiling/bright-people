set :deploy_to, "/var/www/#{application}-dev"
set :rails_env, "development"

load 'config/deploy/srv_avg'
