class Favourite < ActiveRecord::Base
  attr_accessible :user_id, :relation_id, :relation_type

  belongs_to :user
  belongs_to :relation, polymorphic: true

  validates :user_id, :relation_id, :relation_type, presence: :true
  validates :relation_id, uniqueness: { scope: [:relation_type, :user_id] }
end
