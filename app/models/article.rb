class Article < ActiveRecord::Base
  attr_accessible :title, :content, :author, :article_category_id, :article_tag_list, :picture

  acts_as_taggable_on :article_tags

  validates :title, :content, :author, :article_category_id, presence: :true

  belongs_to :article_category
  has_many :comments

  has_attached_file :picture,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"

  validates_attachment_presence :picture
end
