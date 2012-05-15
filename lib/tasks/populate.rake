desc "Fill database with sample data"
task :populate => :environment do
  Rake::Task['db:reset'].invoke
  99.times do |n|
    title = Faker::Lorem.words(1).join(" ").to_s()
    description = Faker::Lorem.sentences(2).join(" ")
    metro_station = Faker::Lorem.words(1).join(" ").to_s();
    address = Faker::Lorem.words(3).join(" ").to_s();
    Activity.create!(title: title,
                description: description,
                organization_id: 1,
                address: address,
                metro_station: metro_station)
  end
end

