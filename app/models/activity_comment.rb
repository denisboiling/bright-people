class ActivityComment < ActiveRecord::Base
  belongs_to :activity

  has_attached_file :picture, styles: { thumb: "84x84^#" },
                              path: ":rails_root/public/system/activity_comments/:attachment/:id/:style/:filename",
                              url: "/system/activity_comments/:attachment/:id/:style/:filename",
                              default_style: :thumb

  scope :parents, where(is_parent: true).order('created_at DESC')
  scope :childrens, where(is_parent: false).order('created_at DESC')

  attr_accessible :content, :commentator, :picture, :is_parent, :activity_id
end
