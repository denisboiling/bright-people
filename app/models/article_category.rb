class ArticleCategory < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: :true

  has_many :articles

  default_scope order: 'position ASC'
end
