class News < ActiveRecord::Base
  default_scope order: 'created_at DESC'

  has_many :photos, class_name: 'NewsPhoto',
                    dependent: :destroy

  has_many :videos, class_name: 'VideoUrl', dependent: :destroy,
                    conditions: "relation_type = 'news'",
                    foreign_key: 'relation_id', before_add: :add_news_type

  attr_accessible :title, :content, :photo, :photos_attributes, :videos_attributes, as: :admin

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

  has_attached_file :photo, styles: { thumb: "160x100^#", slider: '530x370^#' },
                             path: ":rails_root/public/system/news/:attachment/:id/:style/:filename",
                             url: "/system/news/:attachment/:id/:style/:filename",
                             default_style: :thumb

  def add_news_type(video)
    video.relation_type = 'news'
  end

  class << self
    def for_main
      News.all(:limit => 6)
    end
  end

end
