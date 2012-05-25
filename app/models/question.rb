class Question < ActiveRecord::Base
  belongs_to :specialist, class_name: 'User',
                          foreign_key: 'specialist_id'
  belongs_to :user
  belongs_to :category, class_name: 'QuestionCategory'
  has_many :comments, class_name: 'QuestionComment', dependent: :destroy

  attr_accessible :text, :specialist_id

  # Only publish question
  scope :publish, where(publish: true)

  # Set question as publish
  def publish!
    update_attribute(:publish, true)
  end

end
