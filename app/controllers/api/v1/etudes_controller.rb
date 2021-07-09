# app/controllers/api/v1/etudes_controller.rb
class Api::V1::EtudesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: %i[index]
  before_action :set_etude, only: %i[show update]

  def index
    @etudes = policy_scope(Etude)
  end

  def show
    authorize @etude
  end

  def update
    if @etude.update(etude_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_etude
    @etude = Etude.find(params[:id])
    authorize @etude
  end

  def etude_params
    params.require(:etude).permit(:reference)
  end

  def render_error
    render json: { errors: @etude.errors.full_messages },
           status: :unprocessable_entity
  end
end
