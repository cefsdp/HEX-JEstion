class AdherentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @user.junior.adherents
    end
  end

  def signup_step2?
    return true
  end

  def show?
    if @user.admin == false
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
            return true if permission.module_adherent
          end
        end
      else
        # Adherent
        return false
      end
    end
  end

  def edit?
    update?
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
            return true if permission.module_adherent
          end
        end
      else
        # Adherent
        return true
      end
    end
  end
end
