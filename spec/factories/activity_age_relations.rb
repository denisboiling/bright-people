FactoryGirl.define do
  factory :activity_age_relation do
    association :activity, factory: :activity
    association :age_tag, factory: :age_tag
  end
end
