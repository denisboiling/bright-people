FactoryGirl.define do
  factory :organization do
    title { Faker::Lorem.words.join(' ') }
    address { Faker::Address.street_address  }

    association :metro_station, factory: :metro_station
  end
end
