class Region < ActiveRecord::Base
  has_many :activities

  attr_accessible :title, as: :admin

  validates :title, presence: true
end
