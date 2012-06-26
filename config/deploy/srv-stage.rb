set :deploy_to, "/var/www/#{application}-stage"
set :rails_env, "production"
set :branch, "stage"

load 'config/deploy/srv_avg'

before "db:prepare", "unicorn:stop"
before "db:prepare", "thinking_sphinx:stop"
before "db:prepare", "delayed_job:stop"
after "deploy:finalize_update", "db:prepare"
after "deploy:finalize_update", "deploy:migrate"
after "deploy:migrate", "db:load_seed"
after "db:load_seed", "db:load_sample"
after "deploy:migrate", "thinking_sphinx:configure"

after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"
