class Organization < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :address, :metro_station_id, :coords, as: :admin

  validates :title, presence: true

  has_many :activities
  has_many :teachers, through: :activities

  belongs_to :metro_station

  default_scope order: 'title ASC'
  
  def direction_tags
    DirectionTag.joins(:activities => :organization)
                .where('organizations.id = ?', self.id)
                .where('activities.published = TRUE')
                .select('DISTINCT(direction_tags.id), direction_tags.*')
  end
end
