namespace :staging do
  desc "Load database from production server"
  task :load_db => :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute

    @config = ActiveRecord::Base.configurations[Rails.env]
    @tmp_file = "/tmp/bp.sql.gz"

    def dump_db
      %x(ssh rvm_user@bright-people.ru "export PGPASSWORD="NX12NDwvney5GKqaZ_he1u-G" && \
       pg_dump -U brightpeople brightpeople | gzip -9" > #{@tmp_file})
    end

    def restore_dump
      restore_db_str = %Q(export PGPASSWORD="#{@config['password']}" && \
                        zcat #{@tmp_file} | psql -U #{@config['username']} #{@config['database']} )
      puts restore_db_str
      %x(#{restore_db_str})
    end

    if ENV['CACHE_DUMP'] == "true"
      if File.exist?(@tmp_file)
        restore_dump
      else
        dump_db
        restore_dump
      end
    else
      dump_db
      restore_dump
      %x(rm #{@tmp_file})
    end
  end

  desc "Load public/system from production"
  task :load_images do
    folder = ENV['public_folder'] || Rails.root.join('public')
    puts "something wrong" and exit unless folder.present?

    tmp_file = "/tmp/bp-images.tar.gz"
    %x(rm -rf #{File.join(folder, 'system')})

    if File.exist?(tmp_file) && ENV['RELOAD_IMAGES'] != "true"
      puts "Images already exists #{tmp_file}"
    else
      puts "Start download images from production server"
      %x(ssh rvm_user@bright-people.ru "cd /var/www/bright-people/shared && \
                                        tar --exclude=system/gallery_photos --exclude=system/arhives -czf - system" > #{tmp_file})
    end
    %x(cd #{folder} && tar xvf #{tmp_file})
  end
end
