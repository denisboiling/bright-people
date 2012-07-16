namespace :db do
  desc 'Load database from production server'
  task :load_from_server => :environment do
    tmp_file = "/tmp/bp-#{rand(99999).to_s}.sql.gz"
    %x(ssh rvm_user@bright-people.ru "pg_dump -U postgres bp_production | gzip -9" > #{tmp_file})

    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    config = ActiveRecord::Base.configurations[Rails.env]

    puts "Then execute following"
    unless config['password'].present?
      %x(zcat #{tmp_file} | psql -U #{config['username']} #{config['database']} && rm -rf #{tmp_file})
    else
      %x(export PGPASSWORD="#{config['password']} && zcat #{tmp_file} | psql -U #{config['username']} #{config['database']} && rm -rf #{tmp_file}")
      # puts "zcat #{tmp_file} | psql -U #{config['username']} #{config['database']} && rm -rf #{tmp_file}"
    end
  end
end

namespace :images do
  desc "Load images from production. By default public/system will be replaced"
  task :load_from_server do
    folder = ENV['public_folder'] || Rails.root.join('public')
    puts "something wrong" and exit unless folder.present?

    tmp_file = "/tmp/bp-images.tar.gz"
    %x(rm -rf #{File.join(folder, 'system')})
    if File.exist?(tmp_file)
      puts "Images already exists #{tmp_file}"
    else
      puts "Start download images from production server"
      %x(ssh rvm_user@bright-people.ru "cd /var/www/bright-people/shared && tar czf - system" > #{tmp_file})
    end
    %x(cd #{folder} && tar xvf #{tmp_file})
  end
end
