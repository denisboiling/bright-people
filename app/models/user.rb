class User < ActiveRecord::Base
  devise :omniauthable, :registerable, :rememberable, :trackable, :validatable,
         :database_authenticatable

  belongs_to :role
  has_many :activity_votes

  has_many :questions, dependent: :destroy,
                       foreign_key: 'specialist_id'

  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
                    url: "/system/:attachment/:id/:style/:filename"

  attr_accessible :email, :remember_me, :password, :password_confirmation, :avatar

  validates :role, presence: true

  # Callbacks
  before_validation(on: :create) do
    self.role = Role.user
  end

  attr_accessible :email, :name, :password, :remember_me
  attr_accessible :vkontakte_id, :facebook_id, :odnoklassniki_id

  scope :specialists, where(role_id: 4).order('created_at DESC')

  def self.find_or_create_for_vkontakte(data)
    user_id = data.extra.raw_info.uid.to_s
    user = find_by_vkontakte_id(user_id)
    if user
      user
    else
      self.create! vkontakte_id: user_id, password: Devise.friendly_token[0,8],
                   name: data.info.name
    end
  end

  def self.find_or_create_for_facebook(data)
    user_id = data.extra.raw_info.id.to_s
    email = data.extra.raw_info.email
    user = find_by_facebook_id(user_id)
    if user
      user
    else
      self.create! facebook_id: user_id, email: email, password: Devise.friendly_token[0,8],
                   name: data.info.name
    end
  end

  def self.find_or_create_for_odnoklassniki(data)
    user_id = data.extra.raw_info.uid.to_s
    user = find_by_odnoklassniki_id(user_id)
    if user
      user
    else
      self.create! odnoklassniki_id: user_id, password: Devise.friendly_token[0,8],
                   name: data.extra.raw_info.name
    end
  end

  def specialist?
    role == Role.specialist
  end

  def specialist!
    update_attribute(:role, Role.specialist)
  end

  def email_required?
    false
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
