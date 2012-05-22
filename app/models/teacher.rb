class Teacher < ActiveRecord::Base
  attr_accessible :name, :description, :photo, :activity_id
  
  belongs_to :activity

  has_attached_file :photo,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"

  validates :name, :description, :activity, presence: true
  validates_attachment_presence :photo
end
