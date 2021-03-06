# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @no_navbar = true
    super
  end

  # POST /resource
  def create
    @user = User.new(email: config_signup_params[:email], password: config_signup_params[:password],
                     password_confirmation: config_signup_params[:password_confirmation],
                     junior: Junior.find_by(codeje: config_signup_params['junior']))
    @user.save
    @userparam = Userparam.create(user: @user)
    @adherent = Adherent.create(user: @user)
    sign_in_and_redirect(@user, event: :authentication)
  end

  # GET /resource/edit
  def edit
    @junior = current_user.junior
    @user = current_user
    @adherent = current_user.adherent
    @membre = @user.membre
    @mandat = MandatRequest.new
    @mandat_requests = current_user.mandat_requests
    @mandats = current_user.mandats
    @document = DocumentAdhesion.new
    @documents = DocumentAdhesion.where(adherent_id: @adherent.id).order(
      "nom ASC", "date_fin_validite DESC"
    )
    @configuration_id = JuniorConfiguration.find_by(junior_id: @junior.id)
    @document_obligatoires = ConfigDocAdherent.where(junior_configuration_id: @configuration_id, obligatoire: true)
    super
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:junior])
  #   raise
  # end

  def config_signup_params
    params.require(:user).permit(:email, :password, :password_confirmation, :junior, :remember_me)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  #  def after_sign_up_path_for(_resource)
  #    redirect_to junior_signup_step2_path(current_user.junior)
  #  end

  # The path used after sign up for inactive accounts.
  #  def after_inactive_sign_up_path_for(_resource)
  #    redirect_to junior_signup_step2_path(current_user.junior)
  #  end
end
