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
    elsif current_user.membre.admin?
      # Admin JE
      return true
    end
  end

  def update?
    edit?
  end
end
