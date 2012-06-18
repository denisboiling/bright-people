class MetroBranch < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: :true

  has_attached_file :icon, :styles => { :icon => "32x32" },
                              path: ":rails_root/public/system/metro_branches/:attachment/:id/:style/:filename",
                              url: "/system/metro_branches/:attachment/:id/:style/:filename",
                              default_style: :icon

  has_many :metro_stations
end
