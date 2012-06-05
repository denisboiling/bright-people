FactoryGirl.define do
  factory :metro_station do
    title { Faker::Lorem.words.join(' ') }
  end
end
