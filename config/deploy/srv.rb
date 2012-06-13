load 'deploy/assets'

set :deploy_to, "/var/www/#{application}"
set :rails_env, "production"
set :branch, "ezo"

load 'config/deploy/srv_avg'

if ENV['CLEAR']
  before "db:prepare", "unicorn:stop"
  before "db:prepare", "thinking_sphinx:stop"
  before "db:prepare", "delayed_job:stop"
  before "deploy:assets:precompile", "db:prepare"
  after "deploy:migrate", "db:load_seed"
end

before "deploy:assets:precompile", "deploy:migrate"
after "deploy:migrate", "thinking_sphinx:configure"

after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"
