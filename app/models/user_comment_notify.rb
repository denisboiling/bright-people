class UserCommentNotify < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  belongs_to :child_comment, class_name: 'Comment', foreign_key: :child_comment_id
  
  attr_accessible :child_comment, :comment, :user

  class << self
    # Create notify by comment
    def create_notify(_comment)
      return if _comment.top_level?
      self.create(child_comment: _comment, comment: _comment.parent, user: _comment.parent.user)
    end
  end
end
