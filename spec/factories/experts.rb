FactoryGirl.define do
  factory :expert do
    name { Faker::Name.name }
    description { Faker::Lorem.words.join(' ') }
    about { Faker::Lorem.paragraphs(3).join('\n') }
    photo Rack::Test::UploadedFile.new('spec/files/spacer.gif', 'image/gif')
  end
end
