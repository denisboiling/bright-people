class InterviewComment < ActiveRecord::Base
  include Hierarchy
  attr_accessible :author, :content, :interview_id

  belongs_to :interview

  validates :author, :content, presence: :true
end
