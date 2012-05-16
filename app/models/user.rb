class User < ActiveRecord::Base
  devise :omniauthable, :registerable, :rememberable, :trackable, :validatable

  belongs_to :role

  attr_accessible :email, :remember_me

  validates :role, :presence => true

  # Callbacks
  before_create :add_default_role

  def add_default_role
    self.role = Role.user
  end
end
