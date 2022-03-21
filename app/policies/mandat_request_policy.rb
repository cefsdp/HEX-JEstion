class MandatRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if user.membre.nil? == false
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
          @user.permissions.each do |_permission|
            return true
          end
        end
      else
        # Adherent
        return true
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
            return true if permission.update_mandat_request
          end
        end
      else
        # Adherent
        return false
      end
    end
  end

  def destroy?
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
            return true if permission.destroy_mandat_request
          end
        end
      else
        # Adherent
        return false
      end
    end
  end
end
