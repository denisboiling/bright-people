FactoryGirl.define do
  factory :activity_approval do
    text { Faker::Lorem.paragraphs(3).join('\n') }

    association :activity, factory: :activity
    association :user, factory: :expert
  end
end
