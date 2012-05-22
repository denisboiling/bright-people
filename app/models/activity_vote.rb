class ActivityVote < ActiveRecord::Base
  validates :user_id, uniqueness: true
  validates :activity_id, :user_id, :rate, presence: true
  validates :rate, :numericality => { only_integer: true,
                                      greater_than_or_equal_to: 0,
                                      less_than_or_equal_to: 5 }
end
