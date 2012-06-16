set :deploy_to, "/var/www/#{application}-dev"
set :rails_env, "development"
set :branch, "design"

load 'config/deploy/srv_avg'

before "deploy:finalize_update", "deploy:git_design"
after "deploy:finalize_update", "deploy:remove_log_link"

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

namespace :deploy do
  task :git_design, roles: :app do
    run "cd #{latest_release} && git checkout -q -b design origin/design"
  end

  task :remove_log_link, roles: :app do
    run "cd #{latest_release} && rm -rf log && mkdir log"
  end

  namespace :assets do
    task :symlink, roles: :app do
      true
    end
    task :precompile, roles: :app do
      true
    end
  end
end
