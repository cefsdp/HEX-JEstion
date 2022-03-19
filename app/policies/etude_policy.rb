class EtudePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
            if permission.show_etude
              return true
            end
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
          @user.permissions.each do |permission|
            if permission.create_etude
              return true
            end
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
    elsif @user.junior_id == @junior.to_i
      if @user.membre
        if @user.membre.admin
          # Junior Admin
          return true
        else
          # Membre Junior
          @user.permissions.each do |permission|
            if permission.update_etude
              return true
            end
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
