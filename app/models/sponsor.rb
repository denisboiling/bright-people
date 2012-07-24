class Sponsor < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "240x240^#", thumb: "125x125#", main: "130x160^#" },
                            path: ":rails_root/public/system/sponsors/:attachment/:id/:style/:filename",
                            url: "/system/sponsors/:attachment/:id/:style/:filename",
                            default_style: :thumb, default_url: 'loading.gif'

  attr_accessible :first_name, :last_name, :photo, :description, :text, :position

  default_scope order: 'position ASC'

  define_index do
    indexes first_name, sortable: true
    indexes last_name, sortable: true
    indexes description
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
