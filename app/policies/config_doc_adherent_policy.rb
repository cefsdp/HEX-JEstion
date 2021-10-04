class ConfigDocAdherentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        # Admin JEstion
        scope.all
      elsif user.membre.nil?
        if user == adherent.user
          # Adherent
          return false
        else
          # Autre Junior
          return false
        end
      elsif current_user.membre
        if current_user.membre.admin?
          # Admin JE
          current_user.junior.adherents
        else
          # Membre JE
          current_user.junior.adherents
        end
      end
    end
  end

  def create?
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
    elsif current_user.membre
      if current_user.membre.admin?
        # Admin JE
        return true
      else
        # Membre JE
        return false
      end
    end
  end

  def update?
    create?
  end
end
