class Picture < ActiveRecord::Base
  attr_accessible :picture, :caption
  
  has_attached_file :picture,
                    styles: { medium: "440x275>", thumb: "160x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename",
                    default_style: :medium
end
