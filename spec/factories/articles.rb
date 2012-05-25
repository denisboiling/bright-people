# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title Faker::Lorem.words.join(' ')
    content Faker::Lorem.paragraphs(5).join('\n')
    author Faker::Name.name
    article_category FactoryGirl.create(:article_category)
  end
end
