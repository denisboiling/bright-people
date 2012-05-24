class ArticleComment < ActiveRecord::Base
  include Hierarchy
  attr_accessible :author, :content, :article_id

  belongs_to :article

  validates :author, :content, presence: :true
end
