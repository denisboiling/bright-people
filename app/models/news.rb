class News < ActiveRecord::Base
  default_scope order: 'created_at DESC'

  attr_accessible :title, :content, :photo, as: :admin

  has_attached_file :photo, styles: { thumb: "160x100^#", slider: '530x370^#' },
                             path: ":rails_root/public/system/news/:attachment/:id/:style/:filename",
                             url: "/system/news/:attachment/:id/:style/:filename",
                             default_style: :thumb

  class << self
    def for_main
      News.all(:limit => 6)
    end
  end

end
