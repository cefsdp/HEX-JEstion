class AuthorizationContext
  attr_reader :user, :junior

  def initialize(user, junior)
    @user = user
    @junior = Junior.find(junior.to_i)
  end
end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_user

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def pundit_user
    AuthorizationContext.new(current_user, current_junior)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def set_user
    current_user ? cookies[:token] = current_user.authentication_token : cookies[:token] = 'guest'
  end

  def current_junior
    current_junior = params[:junior_id] || params[:id] || nil
  end
end
