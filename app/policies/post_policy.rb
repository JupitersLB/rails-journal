class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def show?
    record.user.friends.map { |friend| friend == user }.include?(true) || record.user == user
  end

  def destroy?
    record.user == user
  end
end
