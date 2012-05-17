class ActivityDirectionRelation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :direction_tag
end
