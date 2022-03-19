class MembreRequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.membre.nil? == false
        scope.where(junior_id: user.junior.id, status: 'pending')
      end
    end
  end

  def show?
    if @user.admin
      # Super Admin
      return true
    elsif @user.junior_id == @junior.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |permission|
            return true if permission.show_membre_request
          end
        end
      else
        # Adherent
        return false
      end
    end
  end

  def new?
    create?
  end

  def create?
    if @user.admin
      # Super Admin
      return true
    elsif @user.junior_id == @junior.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |_permission|
            return false
          end
        end
      else
        # Adherent
        return true
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
    elsif @user.junior_id == @junior.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |permission|
            return true if permission.update_membre_request
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
    elsif @user.junior_id == @junior.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |permission|
            return true if permission.destroy_membre_request
          end
        end
      else
        # Adherent
        return false
      end
    end
  end
end
