class ActivityVote < ActiveRecord::Base
  validates :user_id, uniqueness: true
  validates :activity_id, :user_id, :rate, presence: true
end
