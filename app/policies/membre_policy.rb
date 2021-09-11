class MembrePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if user.membre.nil? == false
    end
  end
end
