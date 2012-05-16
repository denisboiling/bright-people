class Organization < ActiveRecord::Base
  attr_accessible :title, :address, :metro_station
  
  validates :title, presence: true
  validates :address, presence: true
  validates :metro_station, presence: true
  
  has_many :activities
end
