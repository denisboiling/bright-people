class Expert < ActiveRecord::Base
  attr_accessible :name, :description, :photo

  has_attached_file :photo,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"

  validates :name, :description, presence: true
  validates_attachment_presence :photo
end
