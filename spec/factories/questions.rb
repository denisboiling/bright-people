FactoryGirl.define do
  factory :question do
    text { Faker::Lorem.paragraphs.join("\n") }

    association :user, factory: :user
    association :specialist, factory: :specialist
  end
end
