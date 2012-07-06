class Picture < ActiveRecord::Base
  attr_accessible :picture, :caption, as: :admin

  has_attached_file :picture, styles: { medium: "575x305^#" },
                              path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                              url: "/system/:attachment/:id/:style/:filename",
                              default_style: :medium, default_url: 'loading.gif'
end
