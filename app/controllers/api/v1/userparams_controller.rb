class Api::V1::UserparamsController < Api::V1::BaseController
  before_action :skip_authorization

  def index
    users = policy_scope(User)
    users.find_by(authentication_token: token_params).nil? ? render_invalid_token : @userparam = users.find_by(authentication_token: token_params).userparam
  end

  def update
    users = policy_scope(User)
    @userparam = users.find_by(authentication_token: token_params).userparam
    render_success if @userparam.update(navbar_active: navbar_active_params)
  end

  private

  def render_invalid_token
    render json: { errors: 'Invalid Token' },
           status: :unprocessable_entity
  end

  def render_success
    render json: { success: 'Update has succeeded' }
  end

  def token_params
    params.require(:authentication_token)
  end

  def navbar_active_params
    params.require(:navbar_active)
  end
end

# url_for api_v1_userparam_url(authentication_token: current_user.authentication_token)
# url_for api_v1_userparam_url(authentication_token: current_user.authentication_token, userparam: { navbar_active: 1 })
