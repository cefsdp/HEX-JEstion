class AdherentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    if user.admin == true
      # Admin JEstion
      return true
    elsif user.membre.nil?
      if user == adherent.user
        # Adherent
        return false
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

  def edit?
    if user.admin == true
      return true
    elsif user.membre.nil?
      if user == adherent.user
        return true
      else
        return false
      end
    elsif current_user.membre.admin?
      return true
    end
  end

  def update?
    edit?
  end
end
