set :deploy_to, "/var/www/#{application}-dev"
set :rails_env, "development"
set :branch, "design"

load 'config/deploy/srv_avg'

before "deploy:finalize_update", "deploy:git_design"
after "deploy:finalize_update", "deploy:remove_log_link"

after "deploy:finalize_update", "db:prepare"
after "deploy:finalize_update", "deploy:migrate"

namespace :deploy do
  task :git_design, roles: :app do
     run "cd #{latest_release} && git checkout -q -b design origin/design"
  end

  task :remove_log_link, roles: :app do
    run "cd #{latest_release} && rm -rf log && mkdir log"
  end
end
