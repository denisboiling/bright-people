class VideoUrl < ActiveRecord::Base
  belongs_to :activity, conditions: "relation_type = 'activity'",
                        foreign_type: 'relation_id'

  attr_accessible :url
end
