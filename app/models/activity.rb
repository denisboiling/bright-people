class Activity < ActiveRecord::Base
  attr_accessible :title, :description, :organization_id, :users_rating, :metro_station_id
  attr_accessible :experts_rating
  attr_accessible :address, :is_educational
  
  validates :title, presence: true
  validates :description, presence: true
  validates :organization_id, presence: true

  belongs_to :organization
  belongs_to :metro_station
  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations
end
