class ActivityAgeRelation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :age_tag
end
