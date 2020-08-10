class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    record.user == user
  end

  def friends?
    record.user.friends.map { |friend| friend == user }.include?(true) || record.user == user
  end
end
