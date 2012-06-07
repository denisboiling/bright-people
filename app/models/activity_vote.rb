class ActivityVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  validates :user_id, uniqueness: true
  validates :activity_id, :user_id, :rate, presence: true
  # validates :rate, numericality: { only_integer: true,
  #                                  greater_than_or_equal_to: 0,
  #                                  less_than_or_equal_to: 5 }

  attr_accessible :user, :activity, :rate

  class << self
    def update_rating(_user, _activity, _rate)
      if activity_vote = _user.activity_votes.find_by_activity_id(_activity.id)
        activity_vote.update_attribute(:rate, _rate)
      else
        self.create(user: _user, activity: _activity, rate: _rate)
      end
    end
  end
end
