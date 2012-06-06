FactoryGirl.define do
  factory :activity_approval do
    text { Faker::Lorem.paragraphs(3).join('\n') }

    association :activity, factory: :activity
    association :expert, factory: :expert
  end
end
