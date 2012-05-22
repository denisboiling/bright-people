class Activity < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :description, :organization_id, :users_rating,
  :metro_station_id, :experts_rating, :address, :is_educational, :photos_attributes,
  :_destroy, :video_urls_attributes

  validates :title, presence: true
  validates :description, presence: true
  validates :organization, presence: true

  belongs_to :organization
  belongs_to :metro_station

  has_many :activity_direction_relations
  has_many :direction_tags, through: :activity_direction_relations

  belongs_to :age_tag

  has_many :teachers

  has_many :photos,
  class_name: 'ActivityPhoto',
  dependent: :destroy

  has_many :video_urls,
  class_name: 'ActivityVideoUrl',
  dependent: :destroy

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :video_urls, allow_destroy: true

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

  # OPTIMIZE: bad bad bad!!!!
  def video_urls_attributes=(attrs)
    attrs.each do
      attrs.each do |attr|
        url = attr.last
        self.video_urls.create(url)
      end
    end if self.save
  end

  # OPTIMIZE: bad bad bad!!!!
  def photos_attributes=(attrs)
    attrs.each do |attr|
      photo = attr.last
      if photo.keys.include?('_destroy') && photo['_destroy'].to_i == 1
        self.photos.find(photo[:id]).destroy
      else
        photo.reject!{|k,v| k == '_destroy'}
        self.photos.create(photo)
      end
    end if self.save
  end

end
