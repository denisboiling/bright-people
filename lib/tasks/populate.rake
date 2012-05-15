desc "Fill database with sample organizations"
task :populate => :environment do
  Rake::Task['db:reset'].invoke
  5.times do |n|
    FactoryGirl.create(:organization)
  end
end

desc "Fill database with sample activities"
task :populate => :environment do
  36.times do |n|
    FactoryGirl.create(:activity)
  end
end
