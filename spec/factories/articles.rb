FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.words.join(' ') }
    content { Faker::Lorem.paragraphs(5).join("\n") }


    association :category, factory: :article_category
    association :author, factory: :user
  end
end
