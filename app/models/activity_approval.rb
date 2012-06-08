class ActivityApproval < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  attr_accessible :user, :activity

  after_create :approve_activity!

  private

  # When expert create approval we marked activity
  # as approved
  def approved_activity!
    activity.update_attribute(:approved, true)
  end
end
