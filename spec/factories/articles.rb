FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.words.join(' ') }
    content { Faker::Lorem.paragraphs(5).join("\n") }
    publication_date { DateTime.now.to_date - 1.day }


    association :category, factory: :article_category
    association :author, factory: :user
  end
end
