class Sponsor < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "130x100>" },
                            path: ":rails_root/public/system/sponsors/:attachment/:id/:style/:filename",
                            url: "/system/sponsors/:attachment/:id/:style/:filename",
                            default_style: :thumb

  attr_accessible :name, :photo
end
