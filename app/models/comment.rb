class Comment < ActiveRecord::Base
  include Hierarchy

  attr_accessible :text
  belongs_to :user

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
      %w(Question Article Interview News SpecialProject ContestMembership)
    end
  end
end
