class ArticleCategory < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: :true

  has_many :articles
end
