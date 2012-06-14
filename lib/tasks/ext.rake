require 'active_record/fixtures'

namespace :ext do
  desc 'Clear development workspaces'
  task :clear do
    %w[tmp log].each {|d| FileUtils.rm_rf(Rails.root.join(d)) and FileUtils.mkdir(Rails.root.join(d))}
  end
end

namespace :db do
  # TODO: https://gist.github.com/1340242
  # namespace :test do |schema|
  #   schema[:clone_structure].abandon
  #   desc "OVERWRITTEN - load the development_structure file using mysql shell"
  #   task :clone_structure => ["db:test:purge"] do
  #     config = ActiveRecord::Base.configurations['test']
  #     cmd = "mysql #{mysql_options} < db/development_structure.sql"
  #     system cmd
  #   end
  # end

  # def mysql_options
  #   config = ActiveRecord::Base.configurations[Rails.env]
  #   pwd = "-p#{config['password']} " if config['password'].to_s.length > 0
  #   "-u#{config['username'] || config['user']} #{pwd} #{config['database']}"
  # end


  desc 'db:drop db:create db:migrate db:seed db:load_sample'
  task :setup_sample => :environment do
    ['db:drop', 'db:create', 'db:migrate', 'db:seed', 'db:load_sample'].each do |t|
      Rake::Task[t].execute
    end
  end

  desc "Loads a specified fixture using rake db:load_file[filename.rb]"
  task :load_file , [:file] => :environment do |t , args|
    file = args.file
    ext = File.extname file
    if ext == ".csv" or ext == ".yml"
      puts "loading fixture " + file
      ActiveRecord::Fixtures.create_fixtures(File.dirname(file) , File.basename(file, '.*') )
    else
      if File.exists? file
        puts "loading ruby    " + file
        require file
      end
    end
  end

  desc "Loads fixtures from the the dir you specify using rake db:load_dir[loadfrom]"
  task :load_dir , [:dir] => :environment do |t , args|
    dir = args.class == String ? args : args.dir
    fixtures = ActiveSupport::OrderedHash.new
    ruby_files = ActiveSupport::OrderedHash.new
    Dir.glob(File.join(Rails.root, "db", dir , '*.{yml,csv,rb}')).each do |fixture_file|
      ext = File.extname fixture_file
      if ext == ".rb"
        ruby_files[File.basename(fixture_file, '.*')]  = fixture_file
      else
        fixtures[File.basename(fixture_file, '.*')]  = fixture_file
      end
    end
    fixtures.sort.each do |fixture , fixture_file|
      # an invoke will only execute the task once
      Rake::Task["db:load_file"].execute( Rake::TaskArguments.new([:file], [fixture_file]) )
    end
    ruby_files.sort.each do |fixture , ruby_file|
      # an invoke will only execute the task once
      Rake::Task["db:load_file"].execute( Rake::TaskArguments.new([:file], [ruby_file]) )
    end
  end

  desc "Load sample"
  task :load_sample => :environment do
    Rake::Task["db:load_dir"].execute('sample')
    puts "Sample data has been loaded"
  end
end
