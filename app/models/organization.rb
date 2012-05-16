class Organization < ActiveRecord::Base
  attr_accessible :title, :address, :metro_station_id
  
  validates :title, presence: true
  validates :address, presence: true
  validates :metro_station, presence: true
  
  has_many :activities
  belongs_to :metro_station
end
