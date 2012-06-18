class Teacher < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :activity_id, as: :admin

  belongs_to :activity

  has_attached_file :photo, styles: { thumb: "120x120^#" },
                            path: ":rails_root/public/system/teachers/:attachment/:id/:style/:filename",
                            url: "/system/teachers/:attachment/:id/:style/:filename",
                            default_style: :thumb, default_url: 'loading.gif'

  validates :name, :description, presence: true
  validates_attachment_presence :photo
end
