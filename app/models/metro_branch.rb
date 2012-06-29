class MetroBranch < ActiveRecord::Base
  attr_accessible :title, :icon

  validates :title, presence: :true

  has_attached_file :icon, :styles => { :standart_icon => "32x32", :small_icon => "16x16^>" },
                              path: ":rails_root/public/system/metro_branches/:attachment/:id/:style/:filename",
                              url: "/system/metro_branches/:attachment/:id/:style/:filename",
                              default_style: :small_icon

  has_many :metro_stations
end
