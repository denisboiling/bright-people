class Comment < ActiveRecord::Base
  include Hierarchy
  attr_accessible :user, :content, :article_id,
                  :interview_id, :news_id, :parent,
                  :special_project_id

  belongs_to :user
  belongs_to :article
  belongs_to :interview
  belongs_to :news
  belongs_to :special_projects

  validates :content, presence: :true

  def author_name
    if user
      user.name
    else
      "Anonymous"
    end
  end
end
