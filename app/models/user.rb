class User < ActiveRecord::Base
  devise :omniauthable, :registerable, :rememberable, :trackable, :validatable

  attr_accessible :email, :remember_me
end
