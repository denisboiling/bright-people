FactoryGirl.define do
  factory :gallery_photo do
    photo Rack::Test::UploadedFile.new('spec/files/1x1.png', 'image/png')

    association :user, factory: :user
  end
end
