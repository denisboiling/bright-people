set :deploy_to, "/var/www/#{application}-stage"
set :rails_env, "production"
set :branch, "stage"

load 'config/deploy/srv_avg'

before "db:prepare", "unicorn:stop"
before "db:prepare", "thinking_sphinx:stop"
before "db:prepare", "delayed_job:stop"
before "db:prepare", "deploy:remove_assets_folder"

after "deploy:finalize_update", "db:prepare"
after "db:prepare", "db:dump_production"
after "db:dump_production", "deploy:migrate"
after "db:prepare", "public:copy_system_production"


after "deploy:update_code", "thinking_sphinx:configure"
after "deploy:update_code", "delayed_job:restart"
after "deploy:update_code", "thinking_sphinx:rebuild"


namespace :db do
  task :dump_production, roles: :app do
    run %q{
            pg_dump bp_production -U postgres > /tmp/bp.dump.sql &&
            psql -U postgres bp_production_stage < /tmp/bp.dump.sql &&
            rm -rf /tmp/bp.dump.sql
          }
  end
end

namespace :public do
  task :copy_system_production, roles: :app do
    run "rm -rf #{shared_path}/system"
    run "cp -rf /var/www/bright-people/shared/system #{shared_path}/system"
  end
end

namespace :deploy do
  task :remove_assets_folder, roles: :app do
    run "cd #{latest_release} && rm -rf public/assets && mkdir public/assets"
  end
end
