FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.words.join(' ') }
    content { Faker::Lorem.paragraphs(5).join("\n") }
    author { Faker::Name.name }

    association :article_category, factory: :article_category
  end
end
