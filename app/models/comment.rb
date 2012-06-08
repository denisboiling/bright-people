class Comment < ActiveRecord::Base
  include Hierarchy

  attr_accessible :text
  belongs_to :user

  belongs_to :relation, polymorphic: true
  has_many :comment_notifies, class_name: 'UserCommentNofity'

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
