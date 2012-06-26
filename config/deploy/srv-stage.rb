set :deploy_to, "/var/www/#{application}-stage"
set :rails_env, "production"
set :branch, "stage"

load 'config/deploy/srv_avg'

before "db:prepare", "unicorn:stop"
before "db:prepare", "thinking_sphinx:stop"
before "db:prepare", "delayed_job:stop"
after "deploy:finalize_update", "db:prepare"
if ENV['SAMPLE']
  after "db:prepare", "deploy:migrate"
  after "deploy:migrate", "db:load_seed"
  after "db:load_seed", "db:load_sample"
else
  after "db:prepare", "db:dump_production"
  after "db:prepare", "public:copy_system_production"
end

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

  task :remove_system, roles: :app do
    run "rm -rf #{shared_path}/system/*"
  end
end
