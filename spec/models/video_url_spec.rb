require 'spec_helper'

describe VideoUrl do
  before(:all) do
    @url = 'http://www.youtube.com/watch?v=iYWzMvlj2RQ'
  end

  it "Should create code by url" do
    @relation = FactoryGirl.create(:article)
    video = VideoUrl.new
    video.url = @url
    video.relation_type = @relation.class
    video.relation_id = @relation.id
    video.save
    video.code.should == 'iYWzMvlj2RQ'
  end
end
