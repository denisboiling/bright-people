class Ability
  include CanCan::Ability

  def initialize(user, admin_user)
    user ||= User.new

    can :read, Activity
    can :approve, Activity if admin_user
    
    can :access, :dashboard if user.persisted?
    can :create, :comment if user.persisted?
    can :view_disabled, :interview, :is_enabled => false if user.role_id = 2 || user.role_id = 3
  end
end
