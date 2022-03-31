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
    user.admin == true
  end

  def edit?
    update?
  end

  def update?
    user.admin == true
  end

  def update_mode?
    user.membre if @user.junior.id == @junior.id.to_i
  end
end
