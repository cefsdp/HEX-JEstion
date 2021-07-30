class MembreRequestsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.membre.admin?
        scope.where(junior: user.junior)
      end
    end
  end

  def show?
    return true
  end

  def new?
    create?
  end

  def create?
    return true
  end

  def edit?
    update?
  end

  def update?
    user.membre.admin == true
  end
end
