class UserCommentNofity < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  belongs_to :child_comment, class_name: 'Comment', foreign_key: 'child_comment_id'

  attr_accessible :child_comment, :comment

  class << self
    # Create notify by comment
    def create_notify(comment)
      return if comment.top_level?
      create(child_comment: comment, comment: comment.parent)
    end
  end
end
