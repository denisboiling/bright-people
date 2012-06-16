class Sponsor < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "240x240^#", thumb: "160x100^#", main: "160x130^>" },
                            path: ":rails_root/public/system/sponsors/:attachment/:id/:style/:filename",
                            url: "/system/sponsors/:attachment/:id/:style/:filename",
                            default_style: :thumb

  attr_accessible :first_name, :last_name, :photo, :description, as: :admin

  define_index do
    indexes first_name, sortable: true
    indexes last_name, sortable: true
    indexes description
  end

end
