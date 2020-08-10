class FriendRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def search?
    true
  end

  def cancel?
    true
  end

  def accept?
    true
  end

  def decline?
    true
  end
end
