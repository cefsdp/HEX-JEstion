class ApplicationPolicy
  attr_reader :request_junior, :user, :record

  def initialize(authorization_context, record)
    @user = authorization_context.user
    @junior = authorization_context.junior
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user.user
      @junior = user.junior
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
