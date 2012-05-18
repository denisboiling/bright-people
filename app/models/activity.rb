class Activity < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :description, :organization_id, :users_rating, :metro_station_id,
  :experts_rating, :address, :is_educational


  validates :title, presence: true
  validates :description, presence: true
  validates :organization, presence: true

  belongs_to :organization
  belongs_to :metro_station

  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations

  belongs_to :age_tag
end
