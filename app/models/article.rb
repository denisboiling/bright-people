class Article < ActiveRecord::Base
  attr_accessible :title, :content, :author_id, :article_category_id,
                  :article_tag_list, :picture, :short_description,
                  :published, as: :admin


  belongs_to :category, class_name: 'ArticleCategory', foreign_key: :article_category_id
  belongs_to :author, class_name: 'User'

  has_many :comments, as: :relation


  has_attached_file :picture, styles: { medium: "440x275#", slider: "520x320^>", thumb: "160x100>" },
                              path: ":rails_root/public/system/articles/:attachment/:id/:style/:filename",
                              url: "/system/articles/:attachment/:id/:style/:filename",
                              default_style: :thumb


  acts_as_taggable_on :article_tags

  validates :title, :content, :author, :article_category_id, presence: :true

  scope :published, where(published: true)
  scope :not_published, where(published: false)

  define_index do
    indexes title, sortable: true
    indexes content
  end

  class << self
    def for_main
      published.order('created_at DESC').first(5)
    end
  end
end
