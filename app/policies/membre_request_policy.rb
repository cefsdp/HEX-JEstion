class MembreRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.membre.nil? == false
        scope.where(junior_id: user.junior.id, status: 'pending')
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

  def destroy?
    update?
  end
end
