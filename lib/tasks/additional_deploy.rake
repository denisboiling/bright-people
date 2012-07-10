namespace :db do
  # TODO: It's not good when we save password in repository, but...
  # Good when we create rake task for create dump and execute this task remotely,
  # but I am lazy...
  desc 'Load database from production server'
  task :load_from_server => :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    config = YAML::load(File.open(Rails.root.join('config/database.yml')))[Rails.env]
    tmp_file = "/tmp/bp-#{rand(99999).to_s}.sql"
    %x(ssh rvm_user@bright-people.ru "pg_dump bp_production -U postgres" > #{tmp_file})
    %x(psql -U#{config['username']} -p#{config['password']} #{config['database']} < #{tmp_file})
    FileUtils.rm tmp_file
  end
end
