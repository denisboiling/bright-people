FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.paragraph }

    association :user, factory: :user
  end

  factory :comment_question, parent: :comment do
    association :relation, factory: :question
  end
end
