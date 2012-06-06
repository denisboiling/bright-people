class Region < ActiveRecord::Base
  has_many :activities
  
  attr_accessible :title
end
