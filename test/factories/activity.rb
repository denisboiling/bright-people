FactoryGirl.define do
  factory :activity do
    title { Faker::Lorem.words(1).join(" ").to_s() }
    description { Faker::Lorem.sentences(2).join(" ") }
    metro_station { Faker::Lorem.words(1).join(" ").to_s() }
    address { Faker::Lorem.words(3).join(" ").to_s() }
    organization_id { 1+ Random.rand(5) }
  end
end
