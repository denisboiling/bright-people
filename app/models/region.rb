class Region < ActiveRecord::Base
  has_many :activities

  attr_accessible :title

  validates :title, presence: true

  default_scope order: 'title ASC'
end
