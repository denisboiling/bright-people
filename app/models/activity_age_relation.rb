class ActivityAgeRelation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :age_tag
  
  validates :activity, :age_tag, presence: true
end
