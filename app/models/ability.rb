class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # OPTIMIZE: brr... user.id its not good look
    can :access, :dashboard if user.id
    can :create, :comment if user.id
    can :view_disabled, :interview, :is_enabled => false if user.role_id = 2 || user.role_id = 3
  end
end
