class Ability
  include CanCan::Ability

  def initialize(user, admin_user)
    user ||= User.new

    can :read, Activity
    can :approve, Activity if admin_user

    can :manage, :dashboard if user.persisted?
    can :manage, :dashboard_activity if user.manager?

    can :create, :comment if user.persisted?

    can :edit, Activity, :manager_id == user.id

    can :get_comments, Activity
    can :vote, Activity if user.id
    can :vote, ContestMembership do |membership|
      user.persisted? and ContestVote.where(user_id: user.id, membership_id: membership.id)
                                     .empty?
    end
  end
end
