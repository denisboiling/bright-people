class Crew < ActiveRecord::Base
  attr_accessible :name, :description, :photo

  has_attached_file :photo, styles: { medium: "300x300^#", thumb: '125x125^#' },
                           path: ":rails_root/public/system/crew/:attachment/:id/:style/:filename",
                           url: "/system/crew/:attachment/:id/:style/:filename",
                           default_style: :thumb

  validates :name, :description, :photo, presence: true
  validates :description, length: { maximum: 140 }
end
