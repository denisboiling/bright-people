role :web, "192.168.2.101"
role :app, "192.168.2.101"
role :db,  "192.168.2.101", :primary=>true

set :user, "rvm_user"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :use_sudo, true
set :rails_env, "production"

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-1.9.3-head@bright-people'
require "rvm/capistrano"


after "deploy:update","shared:symlinks"
after "shared:symlinks","db:prepare"
after "shared:symlinks","deploy:migrate"
after "deploy:migrate","db:load_seed"
after "db:load_seed","db:load_sample"

before "deploy:restart","deploy:chwon"

# Clear old releases
after "deploy:restart","deploy:cleanup"

namespace :deploy do
  task :chown, :roles => :app do
    run "sudo chown -R www-data:www-data #{shared_path}/system"
  end
end


namespace :db do
  task :load_sample, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:load_sample"
  end

  task :load_seed, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:seed"
  end

  task :prepare, :roles => :app do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake db:drop db:create"
  end
end

namespace :shared do

  task :symlinks, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/rvmrc #{latest_release}/.rvmrc"
  end


end

require 'capistrano-unicorn'

namespace :unicorn do
  desc 'Reload unicorn'
  task :reload, :roles => :app, :except => {:no_release => true} do
    config_path = "#{current_path}/config/unicorn/#{rails_env}.rb"
    if remote_file_exists?(unicorn_pid)
      logger.important("Stopping...", "Unicorn")
      run "kill -s USR2 `cat #{unicorn_pid}`"
    else
      logger.important("No PIDs found. Starting Unicorn server...", "Unicorn")
      if remote_file_exists?(config_path)
        run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec unicorn -c #{config_path} -E #{rails_env} -D"
      else
        logger.important("Config file for \"#{unicorn_env}\" environment was not found at \"#{config_path}\"", "Unicorn")
      end
    end
  end

  desc 'Hard way to restart unicron'
  task :hard_reload, :roles => :app, :except => {:no_release => true} do
    config_path = "#{current_path}/config/unicorn/#{rails_env}.rb"
    if remote_file_exists?(unicorn_pid)
      logger.important("Stopping...", "Unicorn")
      run "kill -TERM `cat #{unicorn_pid}` || echo lol"
      run "rm #{unicorn_pid} || echo lol"
      run "rm /var/www/bright-people/current/tmp/unicorn.sock || echo lol"
      # Sometimes we need to wait
      sleep 5
      run "cd #{current_path} && RAILS_ENV=#{app_env} bundle exec unicorn -c #{config_path} -E #{rails_env} -D"
    else
      logger.important("No PIDs found. Starting Unicorn server...", "Unicorn")
      if remote_file_exists?(config_path)
        run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec unicorn -c #{config_path} -E #{rails_env} -D"
      else
        logger.important("Config file for \"#{unicorn_env}\" environment was not found at \"#{config_path}\"", "Unicorn")
      end
    end
  end
end
