class MembreRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.membre.admin?
        scope.where(junior_id: user.junior.id, status: 'pending')
      else
        scope.all
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
