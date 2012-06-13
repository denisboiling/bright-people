class Teacher < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :activity_id

  belongs_to :activity

  has_attached_file :photo,
  styles: { thumb: "120x120^#" },
  path: ":rails_root/public/system/teachers/:attachment/:id/:style/:filename",
  url: "/system/teachers/:attachment/:id/:style/:filename",
  default_style: :thumb

  validates :name, :description, :activity, presence: true
  validates_attachment_presence :photo
end
