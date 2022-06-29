class EtudePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @user.junior.etudes
    end
  end

  def show?
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
            return true if permission.show_etude
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
    elsif @user.junior_id == @junior.id.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |permission|
            return true if permission.create_etude
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
            return true if permission.update_etude
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
end
