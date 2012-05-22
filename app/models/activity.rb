class Activity < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :description, :organization_id, :users_rating,
  :metro_station_id, :experts_rating, :address, :is_educational, :additional_information, :parent_activities

  validates :title, presence: true
  validates :description, presence: true
  validates :organization, presence: true

  belongs_to :organization
  belongs_to :metro_station

  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations

  belongs_to :age_tag

  has_many :teachers
  has_many :activity_comments

  scope :with_direction, lambda { |id|
    joins(:activity_direction_relations)
      .where('activity_direction_relations.direction_tag_id' => id) }

  scope :with_ages, lambda { |ids|
    where(:age_tag_id => ids) }

  scope :with_station, lambda { |id|
    where(:metro_station_id => id) }

  scope :distinct, select('DISTINCT(activities.id), activities.*')

end
