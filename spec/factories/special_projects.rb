# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :special_project do
    title Faker::Lorem.words.join(' ')
    content Faker::Lorem.paragraphs(5).join('\n')
    author Faker::Name.name
  end
end
