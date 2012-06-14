class ContestVote < ActiveRecord::Base
  belongs_to :contest
  belongs_to :membership, class_name: 'ContestMembership'
  
  attr_accessible :user_id, :rate, :contest_id, :membership_id
  
  validate :contest_consistency
  
  validates :membership_id, :user_id, :contest_id, :rate, presence: true
  validates_uniqueness_of :user_id, scope: :contest_id
  validates :rate, numericality: { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   less_than_or_equal_to: 5 }
  
  private
  
  def contest_consistency
    if not membership or contest != membership.contest
      errors.add(:contest, " should be same for membership")
    end
  end
end
