require 'spec_helper'

describe GalleryPhoto do
  let(:file) { File.new(Rails.root.join('spec/files/pics_032.jpg')) }

  it "Save exif datatime" do
    photo = FactoryGirl.create(:gallery_photo, photo: file)
    photo.shot_date.should == Time.zone.parse('2011-11-02 10:59:58 +0400')
  end

  it "Should be not save duplicate" do
    FactoryGirl.create(:gallery_photo, photo: file)
    photo = FactoryGirl.build(:gallery_photo, photo: file)
    photo.should have(1).error_on(:photo_fingerprint)
  end
end
