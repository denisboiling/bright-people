class Organization < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :address, :metro_station_id, :coords, as: :admin

  validates :title, presence: true

  has_many :activities
  has_many :teachers, through: :activities

  belongs_to :metro_station

  define_index do
    indexes title, sortable: true
  end

  default_scope order: 'title ASC'

  def picture
    'url-to-generic-image-for-organization.png'
  end
end
