class Activity < ActiveRecord::Base
  attr_accessible :title, :description, :organization_id, :rating, :metro_station, :address

  validates :title, presence: true
  validates :description, presence: true
  validates :organization_id, presence: true

  belongs_to :organization
  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations
end
