class Comment < ActiveRecord::Base
  include Hierarchy
  attr_accessible :user, :content, :article_id, :interview_id, :parent

  belongs_to :user
  belongs_to :article
  belongs_to :interview

  validates :content, presence: :true

  def author_name
    if user
      user.name
    else
      "Anonymous"
    end
  end
end
