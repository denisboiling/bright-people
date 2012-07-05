class News < ActiveRecord::Base
  attr_accessible :title, :content, :photo, as: :admin

  has_attached_file :photo, styles: { thumb: "160x100^#", slider: '530x370^#' },
                             path: ":rails_root/public/system/news/:attachment/:id/:style/:filename",
                             url: "/system/news/:attachment/:id/:style/:filename",
                             default_style: :thumb

end
