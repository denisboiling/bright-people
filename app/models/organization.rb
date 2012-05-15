class Organization < ActiveRecord::Base
  attr_accessible :title, :address, :metro_station
  
  validates_presence_of :title
  validates_presence_of :address
  validates_presence_of :metro_station
  
  has_many :activities
end
