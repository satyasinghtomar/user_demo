# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.user?
      can :manage, User, id: user.id
      cannot :index, User
    elsif user.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end