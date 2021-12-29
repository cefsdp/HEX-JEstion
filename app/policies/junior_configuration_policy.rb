class JuniorConfigurationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
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
        return false
      end
    end
  end

  def update?
    edit?
  end

  def archives?
    edit?
  end
end
