class Sponsor < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "240x240^#", thumb: "160x100^#", main: "160x130^#" },
                            path: ":rails_root/public/system/sponsors/:attachment/:id/:style/:filename",
                            url: "/system/sponsors/:attachment/:id/:style/:filename",
                            default_style: :thumb

  attr_accessible :name, :photo, :description
end
