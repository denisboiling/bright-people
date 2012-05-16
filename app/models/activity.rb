class Activity < ActiveRecord::Base
  attr_accessible :title, :description, :organization_id, :rating, :metro_station, :address

  validates :title, presence: true
  validates :description, presence: true
  validates :organization_id, presence: true

  belongs_to :organization
end
