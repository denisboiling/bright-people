class ContestCategory < ActiveRecord::Base
  has_many :contests, foreign_key: :category_id
  
  attr_accessible :name
  
  validates :name, presence: true
end
