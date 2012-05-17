class Activity < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :description, :organization_id, :rating,
  :address, :users_rating, :experts_rating

  validates :title, presence: true
  validates :description, presence: true
  validates :organization, presence: true

  belongs_to :organization
end
