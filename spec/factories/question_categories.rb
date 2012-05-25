FactoryGirl.define do
  factory :question_category do
    title { Faker::Lorem.words.join(' ') }
  end
end
