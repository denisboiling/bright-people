class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Only specialist should can access to specialist dashboard
    can :access, :specialist_dashboard if user.specialist?

    # OPTIMIZE: brr... user.id its not good look
    can :create, :question if user.id
    can :create, :comment if user.id
  end
end
