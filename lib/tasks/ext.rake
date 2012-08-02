# -*- coding: utf-8 -*-
require 'active_record/fixtures'

namespace :ext do
  desc 'Clear development workspaces'
  task :clear do
    %w[tmp log].each {|d| FileUtils.rm_rf(Rails.root.join(d)) and FileUtils.mkdir(Rails.root.join(d))}
    FileUtils.mkdir(Rails.root.join('tmp/sphinx_index'))
  end
end

task :social_posting => :environment do
  Article.where(:posted => false).each do |a|
    SocialPostObserver::publish(a)
  end
  News.where(:posted => false).each do |a|
    SocialPostObserver::publish(a)
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

  task :load_metro => :environment do
    require 'open-uri'
    require 'nokogiri'

    doc = Nokogiri::HTML(open(URI.parse(URI.encode('http://ru.wikipedia.org/wiki/Список_станций_Московского_метрополитена'))))
    doc.xpath('//tr[@align="center"]/td[1]/a').each do |node|
      MetroStation.find_or_create_by_title(node.text)
      puts node.text
    end
  end

  task :load_full_metro => :environment do
    require 'open-uri'
    require 'nokogiri'

    FileUtils.rm_rf Rails.root.join('public/system/metro_branches')

    doc = Nokogiri::HTML(open(URI.parse(URI.encode('http://ru.wikipedia.org/wiki/Список_станций_Московского_метрополитена'))))
    doc.css('td[colspan="6"]').each do |branch|
      t = (branch.text.strip[0,branch.text.index("линия")+4] == "Бутовская лини" ? "Бутовская линия" : branch.text.strip[0,branch.text.index("линия")+4] )
      puts t
      station = MetroBranch.find_by_title(t)
      unless station then
        puts 'Branch' + t + 'not found: creating new'
        station = MetroBranch.new
        station.title = t
        station.save
      end
      iterator =  branch.parent.next.next
      while(!iterator.nil? and iterator.child['colspan'] != '6') do
        m = MetroStation.find_by_title(iterator.child.text)
        unless m then
          puts 'Station' + iterator.child.text + 'not found: creating new'
          m = MetroStation.new
          m.title = iterator.child.text
        end
        m.metro_branch_id = station.id
        m.save
        puts "Metro: " + m.title + "\t" + m.metro_branch_id.to_s + "\t" + iterator.child['colspan'].to_s
        iterator = iterator.next
      end
    end
    Dir.foreach(Rails.root.join('db/sample/files/metro_branches/')) {
      |x|
      puts "Got #{x}"
      zero = MetroBranch.order('id ASC').first.id.to_i - 1 
      if x.split('.')[1]=='png'
        id = x.split('.')[0]
        MetroBranch.find(zero + id.to_i).update_attribute(:icon, File.new(Rails.root.to_s + '/db/sample/files/metro_branches/'+ x))
      end
    }
  end

  desc 'Update activities pictures'
  task :update_activities_pictures => :environment do
    ActivityPhoto.each do |ph|
      ph.update_attribute(:attach, File.new("#{::Rails.root}/public"+ph.attach.url(:original).split('?')[0]))
    end
  end

  desc 'Load pages'
  task :load_pages => :environment do
    Rake::Task["db:load_file"].execute(Rake::TaskArguments.new([:file], ['db/default/pages.yml']))
  end

  desc 'db:drop db:create db:migrate db:seed db:load_sample'
  task :setup_sample => :environment do
    ['db:drop', 'db:create', 'db:migrate', 'db:seed', 'db:load_sample', 'db:load_full_metro'].each do |t|
      Rake::Task[t].execute
    end
  end

  desc "Loads a specified fixture using rake db:load_file[filename.rb]"
  task :load_file , [:file] => :environment do |t , args|
    file = args.file
    ext = File.extname file
    if ext == ".csv" or ext == ".yml"
      puts "loading fixture " + file
      start_time = Time.now
      ActiveRecord::Fixtures.create_fixtures(File.dirname(file) , File.basename(file, '.*') )
      puts "Time for '#{file}':  #{Time.now - start_time}" if ENV['sample_time']
    else
      if File.exists? file
        puts "loading ruby    " + file
        start_time = Time.now
        require file
        puts "Time for '#{file}':  #{Time.now - start_time}" if ENV['sample_time']
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
