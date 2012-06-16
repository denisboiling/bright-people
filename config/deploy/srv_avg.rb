role :web, "bp.balticit.ru"
role :app, "bp.balticit.ru"
role :db,  "bp.balticit.ru", :primary=>true

set :user, "www-data"
set :deploy_via, :remote_cache
set :use_sudo, false

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-1.9.3-p194-perf@bright-people'
require "rvm/capistrano"

before "deploy:finalize_update", "shared:symlinks"

# Clear old releases
after "deploy:restart","deploy:cleanup"

namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    hostname = find_servers_for_task(current_task).first
    exec "ssh -l #{user} #{hostname} -t 'source ~/.bashrc && cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rails c'"
  end
end

namespace :rake_exec do
  desc "Run a rake task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    run("cd #{latest_release}; RAILS_ENV=#{rails_env} rake #{ENV['task']}")
  end
end

namespace :backup do
  desc "Create backup with astrails-safe"
  task :create, :roles => :app do
    run "astrails-safe /home/www-data/backup_db"
    run "astrails-safe /home/www-data/backup_files"
  end

  task :install, :roles => :app do
    run "gem install astrails-safe"
  end

end

namespace :delayed_job do
  desc "Restart the delayed_job process"
  task :restart, :roles => :app do
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} script/delayed_job restart"
  end

  task :stop, :roles => :app do
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} script/delayed_job stop"
  end
end

# TODO: bad bad bad
namespace :deploy do
  task :fix_i18n, :roles => :app do
    run "cd #{latest_release}/config/locales && echo >> *.yml"
  end
end

desc "tail production log files"
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
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
    run "ln -nfs #{shared_path}/config/sphinx.yml #{latest_release}/config/sphinx.yml"
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
