class Activity < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :description, :organization_id, :users_rating,
  :metro_station_id, :experts_rating, :address, :is_educational, :photos_attributes,
  :additional_information, :parent_activities, :videos_attributes

  validates :title, presence: true
  validates :description, presence: true
  validates :organization, presence: true

  belongs_to :organization
  belongs_to :metro_station
  belongs_to :age_tag

  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations

  has_many :teachers
  has_many :votes, :class_name => 'ActivityVote'
  has_many :activity_comments

  has_many :photos,
  class_name: 'ActivityPhoto',
  dependent: :destroy

  has_many :videos,
  class_name: 'VideoUrl',
  dependent: :destroy,
  conditions: "relation_type = 'activity'",
  foreign_key: 'relation_id',
  before_add: :add_activity_type

  # Forcibly set activity relation type for video
  def add_activity_type(video)
    video.relation_type = 'activity'
  end

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

  scope :with_direction, lambda { |id|
    joins(:activity_direction_relations)
      .where('activity_direction_relations.direction_tag_id' => id) }

  scope :with_ages, lambda { |ids|
    where(:age_tag_id => ids) }

  scope :with_station, lambda { |id|
    where(:metro_station_id => id) }

  scope :distinct, select('DISTINCT(activities.id), activities.*')

  define_index do
    indexes title, sortable: true
    indexes description
  end

  # OPTIMIZE:
  def update_rating!
    specialist_role = Role.find_by_name('specialist')
    user_role = Role.find_by_name('user')

    experts_votes = ActivityVote.joins(:user).where('users.role_id = ?', specialist_role.id)
    user_votes = ActivityVote.joins(:user).where('users.role_id = ?', user_role.id)

    experts_rating = experts_votes.average('rate')
    users_rating = user_votes.average('rate')

    experts_rating ||= 0
    users_rating ||= 0

    self.users_rating = users_rating
    self.experts_rating = experts_rating

    self.save!
  end

end
