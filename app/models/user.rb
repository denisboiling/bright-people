class User < ActiveRecord::Base
  devise :omniauthable, :registerable, :rememberable, :trackable, :validatable,
         :database_authenticatable

  belongs_to :role

  has_many :activity_votes
  has_many :contest_votes

  has_many :contest_memberships
  has_many :favourites
  has_many :comments
  has_many :comment_notifies, class_name: 'UserCommentNofity', through: :comments
  has_many :interviews, foreign_key: :author_id
  has_many :articles, foreign_key: :author_id
  has_many :news, foreign_key: :author_id
  
  has_many :activity_approvals
  has_many :approved_activities, through: :activity_approvals, source: :activity

  has_attached_file :avatar,
                    styles: { medium: "300x300^#", thumb: "125x125^#", comment: "84x84^#" },
                    path: ":rails_root/public/system/users/:attachment/:id/:style/:filename",
                    url: "/system/users/:attachment/:id/:style/:filename",
                    default_style: :thumb
  
  #validates_attachment_presence :avatar
  
  attr_accessible :email, :remember_me, :password, :password_confirmation, :avatar, :description

  validates :role, presence: true
  
  scope :experts, lambda { where(role_id: Role.expert.id) }
  
  # Callbacks
  before_validation(on: :create) do
    self.role = Role.user if role.blank?
  end

  attr_accessible :email, :name, :password, :remember_me
  attr_accessible :vkontakte_id, :facebook_id, :odnoklassniki_id

  def approvals_count
    activity_approvals.count
  end
  
  def prev_expert
    User.experts.split(self).first.last
  end
  
  def next_expert
    User.experts.split(self).last.first
  end
  
  def mentions
    comments.map(&:relation)
            .select {|r| r.class.name.in? Comment.possible_relations }
            .uniq
  end
  
  class << self
    def experts_for_main
      User.experts.random(5)
    end
  end

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

  def email_required?
    false
  end

end
