class MetroStation < ActiveRecord::Base
  has_many :organizations
  has_many :activities

  attr_accessible :title, as: :admin

  belongs_to :metro_branch

  default_scope order: 'title ASC'
end
