load 'deploy/assets'

set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :branch, "ezo"

load 'config/deploy/srv_avg'

before "deploy:assets:precompile", "db:prepare"
before "deploy:assets:precompile", "deploy:migrate"
