class VideoUrl < ActiveRecord::Base

  belongs_to :relation, polymorphic: true

  attr_accessible :url, as: :admin

  before_save :update_code

  def update_code
    self.code = self.get_code || '0'
  end

  def get_code
    /(?<=v=)[a-zA-Z0-9\-_]+(?=&)|(?<=[0-9]\/)[^&\n]+|(?<=v=)[^&\n]+/.match(url)[0]
  end

  def preview_url
    "http://img.youtube.com/vi/#{code}/0.jpg"
  end
end
