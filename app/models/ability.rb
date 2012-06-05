class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # OPTIMIZE: brr... user.id its not good look
    can :access, :dashboard if user.id
    can :create, :comment if user.id
  end
end
