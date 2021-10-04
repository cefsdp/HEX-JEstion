class AdherentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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
