class Activity < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :description, :organization_id, :users_rating,
  :metro_station_id, :address, :is_educational,
  :additional_information, :parent_activities, :schedule,
  :photos_attributes, :videos_attributes, :logo, :expert_id, :region_id, :cost

  SCHEDULE_DAYS = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  attr_accessible *SCHEDULE_DAYS

  store :schedule

  def schedule
    map = self[:schedule].map { |day, value| [day, JSON(value)] }
    Hash[map]
  end

  SCHEDULE_DAYS.each do |day|
    define_method(:"#{day}=") do |value|
      value = value.to_json unless value.kind_of? String
      self[:schedule][day] = value
    end

    define_method(day) do
      self[:schedule][day]
    end
  end

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :organization
  belongs_to :metro_station

  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations

  has_many :activity_age_relations
  has_many :age_tags, through: :activity_age_relations

  has_many :teachers
  has_many :votes, class_name: 'ActivityVote'
  has_many :activity_comments

  has_many :photos, class_name: 'ActivityPhoto',
                    dependent: :destroy

  # TODO: replace with polymorphic
  has_many :videos, class_name: 'VideoUrl', dependent: :destroy,
                    conditions: "relation_type = 'activity'",
  foreign_key: 'relation_id', before_add: :add_activity_type

  belongs_to :region

  has_one :approval, class_name: 'ActivityApproval'
  has_one :expert, through: :approval, class_name: 'Expert'

  has_attached_file :logo, styles: { medium: "300x300>", thumb: '125x125', slider: '530x370' },
                           path: ":rails_root/public/system/activities/:attachment/:id/:style/:filename",
                           url: "/system/activities/:attachment/:id/:style/:filename",
                           default_style: :thumb

  # Forcibly set activity relation type for video
  def add_activity_type(video)
    video.relation_type = 'activity'
  end

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

  scope :distinct, select('DISTINCT(activities.id), activities.*')
  scope :by_kind, lambda{|kind| where(is_educational: kind == 'educational' ? true : false)}
  scope :by_age, lambda{|ages| joins(:age_tags).where('age_tags.id IN (?)', ages)}
  scope :by_tag, lambda{|tags| joins(:direction_tags).where('direction_tags.id IN (?)', tags)}
  scope :by_metro, lambda{|metros| where('metro_station_id in (?)', metros)}
  scope :approved, where(approved: true)


  define_index do
    indexes title, sortable: true
    indexes description
  end

  # OPTIMIZE:
  def update_rating!
    user_role = Role.find_by_name('user')

    user_votes = ActivityVote.joins(:user).where('users.role_id = ?', user_role.id)

    users_rating = user_votes.average('rate')

    users_rating ||= 0

    self.users_rating = users_rating

    self.save!
  end

  # Return min age from age_tags
  def min_age
    age_tags.minimum(:start_year)
  end

  # For near places
  def place_near
    region.activities.where('id != ?', self.id).first(4)
  end

  # If activity already has approval, we approved it
  def recheck_approved
    update_attribute(:approved, true) if approval.present?
  end

  class << self
    def for_main
      self.random(4)
    end
  end
end
