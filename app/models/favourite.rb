class Favourite < ActiveRecord::Base
  attr_accessible :user_id, :url

  belongs_to :user

  validates :user_id, :url, presence: :true
  validates_uniqueness_of :url, :scope => :user_id
end
