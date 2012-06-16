class Picture < ActiveRecord::Base
  attr_accessible :picture, :caption, as: :admin

  has_attached_file :picture, styles: { medium: "585x310>" },
                              path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                              url: "/system/:attachment/:id/:style/:filename",
                              default_style: :medium
end
