class NewsPhoto < ActiveRecord::Base
  belongs_to :news

  has_attached_file :attach, styles: { thumb: "100x100^#", slider: '530x370^#' },
                             path: ":rails_root/public/system/news_photos/:attachment/:id/:style/:filename",
                             url: "/system/news_photos/:attachment/:id/:style/:filename",
                             default_style: :thumb
  attr_accessible :attach, as: :admin
end
