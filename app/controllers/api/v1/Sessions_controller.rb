class Api::V1::SessionsController < Api::V1::BaseController
  before_action :skip_authorization, only: :index

  def index
    # @user = policy_scope(User).find_by(email: email_params)
    if policy_scope(User).nil?
      render_nil_user
    else
      users = policy_scope(User)
      if users.find_by(email: email_params).nil?
        render_invalid_user
      else
        user = users.find_by(email: email_params)
        user.valid_password?(password_params) ? @user = user : render_invalid_password
      end
    end
    # raise
  end

  private

  def email_params
    params.require(:email)
  end

  def password_params
    params.require(:password)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end

  def render_invalid_user
    render json: { errors: 'the user does not exist' },
           status: :unprocessable_entity
  end

  def render_invalid_password
    render json: { errors: 'wrong password' },
           status: :unprocessable_entity
  end

  def render_nil_user
    render json: { errors: 'Their is no users, please contact the admin' },
           status: :unprocessable_entity
  end
end

# http://localhost:3000/api/v1/sessions?session%5Bemail%5D=cefsdp%40gmail.com&session%5Bpassword%5D=77262683
# http://localhost:3000/api/v1/sessions?email%5D=cefsdp%40gmail.com&session%5Bpassword%5D=77262683
