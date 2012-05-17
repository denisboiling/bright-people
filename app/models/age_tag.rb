class AgeTag < ActiveRecord::Base
  validates :start_year, :end_year, presence: true
  
  has_many :activities
end
