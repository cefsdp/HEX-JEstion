class EtudePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    create?
  end

  def new?
    create?
  end

  def create?
    if user.admin == true
      # Admin JEstion
      return true
    elsif user.membre.nil?
      if user == adherent.user
        # Adherent
        return true
      else
        # Autre Junior
        return false
      end
    elsif user.membre
      if user.membre.admin?
        # Admin JE
        return true
      else
        # Membre JE
        return true
      end
    end
  end

  def update?
    create?
  end

  def edit?
    create?
  end
end