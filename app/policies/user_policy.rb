class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    record.friends.map { |friend| friend.username == user.username }.include?(true) || record == user || user.admin == true
  end

  def update?
    record == user
  end
end
