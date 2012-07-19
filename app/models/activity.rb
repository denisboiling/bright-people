# -*- coding: utf-8 -*-
class Activity < ActiveRecord::Base
  include LocationExt

  SCHEDULE_DAYS = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

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

  validates :title, :region, :description, :organization, presence: true

  belongs_to :organization
  has_and_belongs_to_many :metro_station

  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations

  has_many :teachers
  has_many :votes, class_name: 'ActivityVote'
  has_many :activity_comments

  has_many :photos, class_name: 'ActivityPhoto',
                    dependent: :destroy

  has_many :favourites, as: :relation, dependent: :destroy
  has_many :videos, class_name: 'VideoUrl', as: :relation, dependent: :destroy

  belongs_to :region

  has_one :approval, class_name: 'ActivityApproval'

  has_one :expert, through: :approval, source: :user

  has_many :managers, class_name: 'User'

  has_attached_file :logo, styles: { medium: "300x300^#", thumb: '160x100^#', approved: '422x114^#', index: '186x114^#' },
                           path: ":rails_root/public/system/activities/:attachment/:id/:style/:filename",
                           url: "/system/activities/:attachment/:id/:style/:filename",
                           default_style: :thumb, default_url: 'loading.gif'

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :activity_comments, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :teachers, allow_destroy: true, reject_if: :all_blank


  attr_accessible :title, :description, :organization_id, :users_rating,
                  :metro_station_id, :address, :is_educational, :metro_station_ids ,
                  :additional_information, :parent_activities, :schedule,
                  :photos_attributes, :videos_attributes, :logo, :expert_id, :region_id, :cost,
                  :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :address_dummy,
                  :coords, :activity_comments_attributes, :teachers_attributes, :published,
                  :phone, :site, :direction_tag_ids, :replace_teacher_text, :logo, :start_age, :end_age,
                  :participant, :organization

  scope :distinct, select('DISTINCT(activities.id), activities.*')
  scope :educationals, where(is_educational: true)
  scope :entertainments, where(is_educational: false)
  scope :published, where(published: true)
  scope :not_published, where(published: false)
  scope :by_kind, lambda { |kind| where(is_educational: kind == 'educational') }
  scope :by_tag, lambda { |tags| joins(:direction_tags).where('direction_tags.id IN (?)', tags) }
  scope :by_metro, lambda { |metros| 
  #where('metro_station_id in (?)', metros)
    {
      :include => :metro_station,
      :conditions => [ "metro_stations.id IN (?)", metros ]
    }
  }
  scope :by_region, lambda { |regions| where('region_id in (?)', regions) }
  #TODO : optimize
  scope :by_coords, lambda { |coords| where("ST_Distance(location,(ST_GeogFromText('SRID=4326;POINT(:x :y)'))) <= :max_distance", {:x => coords.split(/, |,/)[0].to_f, :y => coords.split(/, |,/)[1].to_f, :max_distance => 2500}) }
  scope :approved, where(approved: true)


  # OPTIMIZE: maybe..or no???
  scope :by_agerange, lambda { |ages|
    _ages = ages.map{|_age| (_age.split('-')[0].to_i.._age.split('-')[1].to_i).to_a }.flatten.uniq
    where('start_age in (:s_age) OR end_age in (:s_age)', s_age: _ages)
  }

  define_index do
    indexes title, sortable: true
    indexes description
  end

  # to fit common views
  def picture
    logo
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

  # Simple show age like "1-3"
  def age_range
    [start_age, end_age].join(' — ')
  end

  # For near places
  def place_near
    region.activities.published.where('id != ?', self.id).first(4)
  end

  # If activity already has approval, we approved it
  def recheck_approved
    update_attribute(:approved, true) if approval.present?
  end

  # Is activity is educational?
  def is_edu?
    is_educational
  end

  # OPTIMIZE: a lot of SQL query
  # Find max count of schedules per day
  # TODO: remove rescue, it's unacceptably
  def max_schedule_items
    begin
      _max = self[:schedule].map {|k,v| schedule[k].size}.max
      _max == 0 ? nil : _max
    rescue
      nil
    end
  end

  class << self
    # def for_main
    #   self.random(4)
    # end

    # TODO: replace!!!!
    def nice_approval(_scope)
      arr = []
      _scope.each_with_index do |_activity, index|
        next if (index+1)%5 == 0 && _activity.approved?
        arr << _activity
      end
      arr
    end

  end
end
