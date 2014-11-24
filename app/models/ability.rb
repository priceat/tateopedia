class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role? :standard
        can :manage, Wiki, :user_id => user.id, :private => false
    end

    if user.role? :premium
        can :manage, Wiki, :user_id => user.id
        can :manage, Wiki, :collaborations => {:user_id => user.id}
        can :manage, Collaboration

    end

    if user.role? :admin
        can :manage, :all
    end
    can :read, Wiki, private: false
    
  end
end
