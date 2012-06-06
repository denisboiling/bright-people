class ActivityDirectionRelation < ActiveRecord::Base
  belongs_to :activity
  belongs_to :direction_tag

  validate :kind_match

  private

  def kind_match
    match = !!activity.is_educational == !!direction_tag.is_educational
    errors.add(:activity, ", direction kind must match") unless match
  end
end
