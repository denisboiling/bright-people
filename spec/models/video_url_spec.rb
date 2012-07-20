require 'spec_helper'

describe VideoUrl, current: true do
  it "Check video urls regexp" do
    urls = [ 'http://www.youtube.com/watch?v=iYWzMvlj2RQ',
             'http://youtu.be/iYWzMvlj2RQ' ]

    video = VideoUrl.new
    urls.each do |url|
      video.url = url
      video.get_code.should == 'iYWzMvlj2RQ'
    end
  end
end
