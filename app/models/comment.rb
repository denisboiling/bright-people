class Comment < ActiveRecord::Base
  include Hierarchy
  attr_accessible :user_id, :content, :article_id

  belongs_to :user
  belongs_to :article
  belongs_to :interview

  validates :user_id, :content, presence: :true
end
