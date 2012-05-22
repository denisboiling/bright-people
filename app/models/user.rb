class User < ActiveRecord::Base
  devise :omniauthable, :registerable, :rememberable, :trackable, :validatable,
         :database_authenticatable

  belongs_to :role
  
  has_many :activity_votes

  attr_accessible :email, :remember_me

  validates :role, presence: true

  # Callbacks
  before_validation(on: :create) do
    self.role = Role.user
  end

  attr_accessible :email, :password, :remember_me
  attr_accessible :vkontakte_id, :facebook_id, :odnoklassniki_id

  def self.find_or_create_for_vkontakte(data)
    user_id = data.extra.raw_info.uid.to_s
    user = find_by_vkontakte_id(user_id)
    if user
      user
    else
      self.create! vkontakte_id: user_id, password: Devise.friendly_token[0,8]
    end
  end

  def self.find_or_create_for_facebook(data)
    user_id = data.extra.raw_info.id.to_s
    email = data.extra.raw_info.email
    user = find_by_facebook_id(user_id)
    if user
      user
    else
      self.create! facebook_id: user_id, email: email, password: Devise.friendly_token[0,8]
    end
  end

  def self.find_or_create_for_odnoklassniki(data)
    user_id = data.extra.raw_info.uid.to_s
    user = find_by_odnoklassniki_id(user_id)
    if user
      user
    else
      self.create! odnoklassniki_id: user_id, password: Devise.friendly_token[0,8]
    end
  end
  
  def specialist?
    role.name == 'specialist'
  end

  def email_required?
    false
  end
end
