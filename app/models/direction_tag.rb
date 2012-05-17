class DirectionTag < ActiveRecord::Base
  has_many :activity_direction_relations
  has_many :activities, through: :activity_direction_relations
end
