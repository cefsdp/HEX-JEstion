class EtudePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      raise
    end
  end

  def show?
    user.email == "cefsdp@gmail.com"
  end

  def update?
    user.email == "cefsdp@gmail.com"
  end
end
