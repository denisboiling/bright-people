class ActivityComment < ActiveRecord::Base
  attr_accessible :content, :commentator, :picture, :is_parent, :activity_id

  belongs_to :activity

  has_attached_file :picture,
  styles: { medium: "300x300>", thumb: "84x84#" },
  path: ":rails_root/public/system/activity_comments/:attachment/:id/:style/:filename",
  url: "/system/activity_comments/:attachment/:id/:style/:filename",
  default_style: :thumb

  scope :parents, where(is_parent: true)
  scope :childrens, where(is_parent: false)
end
