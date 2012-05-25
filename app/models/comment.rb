class Comment < ActiveRecord::Base
  include Hierarchy
  attr_accessible :user, :content, :article_id, :interview_id, :news_id, :parent

  belongs_to :user
  belongs_to :article
  belongs_to :interview
  belongs_to :news

  validates :content, presence: :true

  def author_name
    if user
      user.name
    else
      "Anonymous"
    end
  end
end
