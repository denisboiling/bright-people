class QuestionComment < ActiveRecord::Base
  include Hierarchy

  belongs_to :question
  belongs_to :user

  attr_accessible :text

  # If question is not publish and question specialist create answer
  # mark question as publish
  after_create :publish_question

  def publish_question
    question.publish! if !question.publish && user == question.specialist
  end
end
