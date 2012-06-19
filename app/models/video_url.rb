class VideoUrl < ActiveRecord::Base
  belongs_to :activity, conditions: "relation_type = 'activity'",
                        foreign_type: 'relation_id'

  attr_accessible :url, as: :admin
  
  def code
    /v=([\d\w]+)/.match(url)[1]
  end
  
  def preview_url
    "http://img.youtube.com/vi/#{code}/0.jpg"
  end
end
