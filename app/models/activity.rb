class Activity < ActiveRecord::Base
  attr_accessible :title, :description, :organization_id, :rating, :metro_station, :address
  
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :organization_id
  
  belongs_to :organization
end
