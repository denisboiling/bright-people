FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password 'password'
  end

  factory :expert, parent: :user do
    name { Faker::Name.name }
    description { Faker::Lorem.words.join(' ') }
    about { Faker::Lorem.paragraphs(3).join('\n') }
    avatar Rack::Test::UploadedFile.new('spec/files/spacer.gif', 'image/gif')
  end
end
