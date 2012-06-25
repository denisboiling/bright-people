class DirectionTag < ActiveRecord::Base
  has_many :activity_direction_relations
  has_many :activities, through: :activity_direction_relations

  validates :name, presence: true #:is_educational, presence: true

  scope :educational, where(is_educational: true)
  scope :entertainment, where(is_educational: [false, nil])
  
  def kind
    is_educational ? 'educational' : 'entertainment'
  end
end
