set :deploy_to, "/var/www/#{application}-dev"
set :rails_env, "development"
set :branch, "design"

load 'config/deploy/srv_avg'

before "deploy:finalize_update", "deploy:git_design"

namespace :deploy do
  task :git_design, roles: :app do
     run "cd #{latest_release} && git checkout -q -b design origin/design"
  end
end
