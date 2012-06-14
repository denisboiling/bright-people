FactoryGirl.define do
  factory :activity do
    title { Faker::Lorem.words.join(' ') }
    description { Faker::Lorem.paragraphs(3).join('\n') }
    address { Faker::Address.street_address  }

    association :organization, factory: :organization
    association :region, factory: :region
  end
end
