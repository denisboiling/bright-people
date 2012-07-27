class Region < ActiveRecord::Base
  has_many :activities
  has_many :metro_stations

  attr_accessible :title

  validates :title, presence: true

  default_scope order: 'title ASC'
end
