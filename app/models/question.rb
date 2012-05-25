class Question < ActiveRecord::Base
  belongs_to :specialist, class_name: 'User',
                          foreign_key: 'specialist_id'
  belongs_to :user

  attr_accessible :text, :specialist_id
end
