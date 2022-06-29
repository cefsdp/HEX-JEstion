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
      elsif user.membre
        if user.membre.admin?
          # Admin JE
          user.junior.adherents
        else
          # Membre JE
          user.junior.adherents
        end
      end
    end
  end

  def create?
    if @user.admin
      # Super Admin
      return true
    elsif @user.junior_id == @junior.id.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |permission|
            return true if permission.module_parametres
          end
        end
      else
        # Adherent
        return false
      end
    end
  end

  def update?
    if @user.admin
      # Super Admin
      return true
    elsif @user.junior_id == @junior.id.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |permission|
            return true if permission.module_parametres
          end
        end
      else
        # Adherent
        return false
      end
    end
  end
end
