class Comment < ActiveRecord::Base
  include Hierarchy

  attr_accessible :text
  belongs_to :user

  belongs_to :relation, polymorphic: true
  has_many :comment_notifies, class_name: 'UserCommentNofity'

  after_create :publish_question

  # Mark question as publish
  def publish_question
    return if relation.class.name != 'Question'
    relation.publish! if !relation.publish && user == relation.specialist
  end

  after_create :create_user_notify

  # Create user notify when somebody commenting his comment
  def create_user_notify
    UserCommentNofity.create_notify(self)
  end

  class << self
    # Return all possible relation type
    def possible_relations
      %w(Article Interview News SpecialProject ContestMembership)
    end
  end
end
