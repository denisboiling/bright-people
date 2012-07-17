desc "tail production log files"
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/#{rails_env}.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end

namespace :deploy do
  task :remove_assets_folder, roles: :app do
    run "cd #{latest_release} && rm -rf public/assets && mkdir public/assets"
  end
end

namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    hostname = find_servers_for_task(current_task).first
    exec "ssh -l #{user} #{hostname} -t 'source ~/.bashrc && export LC_ALL=ru_RU.utf8 && cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rails c'"
  end
end

namespace :rake_exec do
  desc "Run a rake task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    run("cd #{latest_release}; RAILS_ENV=#{rails_env} rake #{ENV['task']}")
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

namespace :shared do
  task :symlinks, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/rvmrc #{latest_release}/.rvmrc"
    run "ln -nfs #{shared_path}/config/sphinx.yml #{latest_release}/config/sphinx.yml"
  end
end

namespace :load_staging do
  task :db, :roles => :app do
    cache_dump = ENV['CACHE_DUMP'] ? true : false
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} CACHE_DUMP=#{cache_dump} bundle exec rake staging:load_db"
  end

  task :images, :roles => :app do
    reload_images = ENV['RELOAD_IMAGES'] ? true : false
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} RELOAD_IMAGES=#{reload_images} bundle exec rake staging:load_images"
  end
end

require 'capistrano-unicorn'

namespace :unicorn do
  desc 'Reload unicorn'
  task :reload, :roles => :app, :except => {:no_release => true} do
    config_path = "#{current_path}/config/unicorn/#{rails_env}_#{stage}.rb"
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
