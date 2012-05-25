FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    name { Faker::Name.name }
  end

  factory :specialist, parent: :user do
    description { Faker::Lorem.sentences.join("\n") }
    after(:create) {|user| user.specialist! }
  end

end
