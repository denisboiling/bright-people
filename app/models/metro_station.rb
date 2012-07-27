class MetroStation < ActiveRecord::Base
  has_many :organizations
  has_and_belongs_to_many :activities
  belongs_to :metro_branch
  belongs_to :region

  attr_accessible :title

  validate :region, presence: :true

  default_scope order: 'title ASC'
end
