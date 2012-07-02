class Ability
  include CanCan::Ability

  def initialize(user, admin_user)
    user ||= User.new

    can :read, Activity
    can :approve, Activity if admin_user

    can :manage, :dashboard if user.persisted?
    can :create, :comment if user.persisted?

    can :edit, Activity if :manager_id == user.id

    # TODO: replace role_id with role method as admin?
    # can :view_disabled, :interview, :is_enabled => false if user.role_id == 2 || user.role_id == 3

    can :get_comments, Activity
    can :vote, Activity if user.id
    can :vote, ContestMembership do |membership|
      user.persisted? and ContestVote.where(user_id: user.id, membership_id: membership.id)
                                     .empty?
    end
  end
end
