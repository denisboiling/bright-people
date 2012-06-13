class Favourite < ActiveRecord::Base
  attr_accessible :user_id, :url

  belongs_to :user
  belongs_to :relation, polymorphic: true

  validates :user_id, :url, presence: :true
  validates_uniqueness_of :url, :scope => :user_id
end
