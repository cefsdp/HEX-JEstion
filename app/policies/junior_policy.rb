class JuniorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def new?
    create?
  end

  def create?
    current_user.admin == true
  end

  def edit?
    update?
  end

  def update?
    current_user.admin == true
  end
end
