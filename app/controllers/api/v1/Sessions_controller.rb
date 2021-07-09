class Api::V1::SessionsController < Api::V1::BaseController
  before_action :skip_authorization, only: :index

  def index
    @params = { session: { email: "cefsdp@gmail.com", password: "77262683" } }
    @user = policy_scope(User).find_by(email: session_params[:email])
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
           status: :unprocessable_entity
  end
end

# http://localhost:3000/api/v1/sessions?session%5Bemail%5D=cefsdp%40gmail.com&session%5Bpassword%5D=77262683
