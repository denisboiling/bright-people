class Organization < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :address, :metro_station_id, :coords, as: :admin

  validates :title, presence: true

  has_many :activities
  belongs_to :metro_station

  define_index do
    indexes title, sortable: true
  end

  default_scope order: 'title ASC'

  def picture
    'url-to-generic-image-for-organization.png'
  end

  # TODO: replace, ugly
  def teachers
    arr = Array.new
    self.activities.each do |activity|
      activity.teachers.each do |t|
        arr << t
      end
    end
    arr.uniq
  end
end
