load 'deploy/assets'

set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :branch, "master"

load 'config/deploy/srv_avg'

before "deploy:assets:precompile", "db:prepare"
before "deploy:assets:precompile", "deploy:migrate"
before "db:prepare", "unicorn:stop"

before "db:prepare", "thinking_sphinx:stop"

after "deploy:migrate", "db:load_seed"
after "deploy:migrate", "thinking_sphinx:configure"

after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"



