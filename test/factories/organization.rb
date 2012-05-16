FactoryGirl.define do
  factory :organization do
    title { Faker::Lorem.words(1).join(" ").to_s() }
    metro_station { Faker::Lorem.words(1).join(" ").to_s() }
    address { Faker::Lorem.words(3).join(" ").to_s() }
  end
end
