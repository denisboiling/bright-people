class ContestVote < ActiveRecord::Base
  belongs_to :contest
  belongs_to :membership, class_name: 'ContestMembership'
  
  validate :contest_consistency
  
  validates :membership_id, :user_id, :contest_id, :rate, presence: true
  validates :user_id, uniqueness: true
  validates :rate, numericality: { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   less_than_or_equal_to: 5 }
  
  private
  
  def contest_consistency
    errors.add(:contest, " should be same for membership") unless contest == membership.contest
  end
end
