# Set unicorn options
worker_processes 2
preload_app true
timeout 30
pid "/var/www/bright-people/shared/pids/unicorn.pid"
listen "/var/www/bright-people/shared/pids/unicorn.sock", :backlog => 64

# Log everything to one file
stderr_path "/var/www/bright-people/current/log/unicorn.log"
stdout_path "/var/www/bright-people/current/log/unicorn.log"

if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  old_pid = '/var/www/bright-people/shared/pids/unicorn.pid.oldbin'
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

  begin
    uid, gid = Process.euid, Process.egid
    user, group = 'www-data', 'www-data'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if RAILS_ENV == 'development'
      STDERR.puts "couldn't change user, oh well"
    else
      raise e
    end
  end
end
