# Set unicorn options
worker_processes 2
preload_app true
timeout 30
pid "/var/www/bright-people-dev/shared/pids/unicorn.pid"
listen "/var/www/bright-people-dev/shared/pids/unicorn.sock", :backlog => 64

# Log everything to one file
stderr_path "/var/www/bright-people-dev/current/log/unicorn.log"
stdout_path "/var/www/bright-people-dev/current/log/unicorn.log"

before_fork do |server, worker|
  old_pid = '/var/www/bright-people-dev/shared/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
