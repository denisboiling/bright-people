FactoryGirl.define do
  factory :gallery_photo do
    photo Rack::Test::UploadedFile.new('spec/files/spacer.gif', 'image/gif')

    association :user, factory: :user
  end
end
