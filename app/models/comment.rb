class Comment < ActiveRecord::Base
  include Hierarchy
  # attr_accessible :user, :content, :article_id,
  #                 :interview_id, :news_id, :parent,
  #                 :special_project_id



  attr_accessible :text
  belongs_to :user
  # belongs_to :article
  # belongs_to :interview
  # belongs_to :news
  # belongs_to :special_projects

  # validates :content, presence: :true

  # def author_name
  #   if user
  #     user.name
  #   else
  #     "Anonymous"
  #   end
  # end

  belongs_to :relation, polymorphic: true

  after_create :publish_question

  # Mark question as publish
  def publish_question
    return if relation.class.name != 'Question'
    relation.publish! if !relation.publish && user == relation.specialist
  end

  class << self
    # Return all possible relation type
    def possible_relations
      %w(Question Article)
    end
  end
end
