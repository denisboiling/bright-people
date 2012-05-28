class Contest < ActiveRecord::Base
  belongs_to :category, class_name: 'ContestCategory'
  
  attr_accessible :name, :started_at, :ended_at
end
