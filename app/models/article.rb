class Article < ActiveRecord::Base
  attr_accessible :title, :content, :author_id, :article_category_id, :article_tag_list, :picture, :short_description

  acts_as_taggable_on :article_tags

  validates :title, :content, :author, :article_category_id, presence: :true

  belongs_to :article_category
  belongs_to :author, class_name: 'User'

  has_many :comments, as: :relation

  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "160x100>" },
                    path: ":rails_root/public/system/articles/:attachment/:id/:style/:filename",
                    url: "/system/articles/:attachment/:id/:style/:filename",
                    default_style: :thumb


  class << self
    def for_main
      order('created_at DESC').first(5)
    end
  end
end
