class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is? :admin
      can :manage, :all
    else
      can :read, :all
      can :create, Post
      can :create, Comment
      can :delete, Post, author_id: user.id
      can :delete, Comment, user_id: user.id
    end
  end
end
