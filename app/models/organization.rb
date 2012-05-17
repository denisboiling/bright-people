class Organization < ActiveRecord::Base
  include LocationExt

  attr_accessible :title, :address, :metro_station

  validates :title, presence: true
  validates :address, presence: true

  has_many :activities
end
