class Comment < ActiveRecord::Base
  include Hierarchy

  attr_accessible :text
  belongs_to :user

  belongs_to :relation, polymorphic: true
  has_many :comment_notifies, class_name: 'UserCommentNotify'

  after_create :create_user_notify
  after_create :update_comments_count!

  # Create user notify when somebody commenting his comment
  def create_user_notify
    UserCommentNotify.create_notify(self)
  end
  
  def update_comments_count!
    return unless relation_type == 'Article' or relation_type == 'Interview' or relation_type == 'News'
    relation.comments_count = relation.comments.count
    relation.save!
  end

  class << self
    # Return all possible relation type
    def possible_relations
      %w(Article Interview News SpecialProject ContestMembership)
    end
  end
end
