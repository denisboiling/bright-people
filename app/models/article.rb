class Article < ActiveRecord::Base
  belongs_to :category, class_name: 'ArticleCategory', foreign_key: :article_category_id
  belongs_to :author, class_name: 'User'

  has_many :comments, as: :relation
  has_many :favourites, as: :relation, dependent: :destroy
  has_many :videos, class_name: 'VideoUrl', as: :relation, dependent: :destroy

  has_many :photos, class_name: 'ArticlePhoto', dependent: :destroy

  has_attached_file :picture, styles: { medium: "440x275^#", slider: "530x370#", thumb: "160x100^#" },
                              path: ":rails_root/public/system/articles/:attachment/:id/:style/:filename",
                              url: "/system/articles/:attachment/:id/:style/:filename",
                              default_style: :thumb, default_url: 'loading.gif'

  # Use this hook, becouse it's model twin to News
  alias photo picture

  acts_as_taggable_on :article_tags

  attr_accessible :title, :content, :author_id, :article_category_id,
                  :article_tag_list, :picture, :short_description,
                  :published, :biography, :best, :publication_date,
                  :photos_attributes,  :videos_attributes


  validates :title, :content, :author, :article_category_id,
            :publication_date, presence: :true

  scope :published, where(published: true)
  scope :not_published, where(published: false)
  scope :bests, where(best: true)
  scope :expect, lambda{|article| where('id != ?', article.id)}
  scope :last5, lambda{|article| where('published = true AND id != ?', article.id).last(5) }

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

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
