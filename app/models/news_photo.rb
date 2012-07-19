class NewsPhoto < ActiveRecord::Base
  belongs_to :news

  has_attached_file :attach, styles: { thumb: "100x100^#", slider: '530x370^#', large: '1366x768' },
                             path: ":rails_root/public/system/news_photos/:attachment/:id/:style/:filename",
                             url: "/system/news_photos/:attachment/:id/:style/:filename",
                             default_style: :thumb

  has_many :videos, class_name: 'VideoUrl', as: :relation, dependent: :destroy

  attr_accessible :attach
end
