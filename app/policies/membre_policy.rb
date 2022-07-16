class MembrePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @user.junior.membres
    end
  end
end
