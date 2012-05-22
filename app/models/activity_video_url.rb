class ActivityVideoUrl < ActiveRecord::Base
  belongs_to :activity
  attr_accessible :url
end
