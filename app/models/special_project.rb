class SpecialProject < ActiveRecord::Base
  attr_accessible :title, :content, :author, :special_project_tag_list, :picture

  acts_as_taggable_on :special_project_tags

  validates :title, :content, :author, presence: :true

  has_many :comments, as: :relation

  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "160x100>" },
                    path: ":rails_root/public/system/special_projects/:attachment/:id/:style/:filename",
                    url: "/system/special_projects/:attachment/:id/:style/:filename",
                    default_style: :thumb

  scope :for_main, self.order('created_at DESC').first(5)
end
