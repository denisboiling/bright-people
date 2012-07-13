class News < ActiveRecord::Base
  has_many :photos, class_name: 'NewsPhoto', dependent: :destroy

  has_many :videos, class_name: 'VideoUrl', dependent: :destroy,
                    conditions: "relation_type = 'news'",
                    foreign_key: 'relation_id', before_add: :add_news_type


  default_scope order: 'created_at DESC'
  scope :published, where("publication_date <= ?", DateTime.now )

  validates :title, :content, :publication_date, presence: true

  attr_accessible :title, :content, :photo, :photos_attributes, :videos_attributes, :publication_date, :news_tag_list, :full_text, as: :admin

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

  acts_as_taggable_on :news_tags

  has_attached_file :photo, styles: { thumb: "160x100^#", slider: '530x370^#' },
                             path: ":rails_root/public/system/news/:attachment/:id/:style/:filename",
                             url: "/system/news/:attachment/:id/:style/:filename",
                             default_style: :thumb

  def published?
    return false if self.publication_date.blank?
    self.publication_date <= DateTime.now
  end

  def add_news_type(video)
    video.relation_type = 'news'
  end

  class << self
    def for_main
      News.published(:limit => 6)
    end
  end

end