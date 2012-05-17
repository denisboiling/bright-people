class MetroStation < ActiveRecord::Base
  attr_accessible :title

  has_many :organizations
  has_many :activities
end
