FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :specialist, parent: :user do
    description { Faker::Lorem.sentences.join("\n") }
    after_create do |user|
      user.specialist!
    end
  end

end
