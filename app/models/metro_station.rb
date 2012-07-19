class MetroStation < ActiveRecord::Base
  has_many :organizations
  has_and_belongs_to_many :activities

  attr_accessible :title

  belongs_to :metro_branch

  default_scope order: 'title ASC'
end
