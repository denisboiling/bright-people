class ActivityApproval < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  attr_accessible :user_id, :activity_id, :text, as: :admin

  after_create :approve_activity!

  private

  # When expert create approval we marked activity
  # as approved
  def approve_activity!
    activity.update_attribute(:approved, true)
  end
end
