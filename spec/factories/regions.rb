FactoryGirl.define do
  factory :region do
    title { Faker::Lorem.words.join(' ') }
  end
end
