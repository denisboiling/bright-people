class VideoUrl < ActiveRecord::Base

  belongs_to :relation, polymorphic: true

  attr_accessible :url, :relation

  before_save :update_code

  def update_code
    self.code = self.get_code || '0'
  end

  def get_code
    /(?<=v=|youtu\.be\/)[a-zA-Z0-9\-_]+/.match(url)[0]
  end

  def preview_url
    "http://img.youtube.com/vi/#{code}/0.jpg"
  end
end
