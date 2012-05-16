class Activity < ActiveRecord::Base
  attr_accessible :title, :description, :organization_id, :rating, :metro_station_id
  attr_accessible :address, :is_educational
  
  validates :title, presence: true
  validates :description, presence: true
  validates :organization_id, presence: true
  
  belongs_to :organization
  belongs_to :metro_station
end
