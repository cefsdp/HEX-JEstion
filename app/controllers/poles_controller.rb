class PolesController < ApplicationController
  before_action :authenticate_user!

  def create
    @pole = Pole.new(pole_params)
    @pole.junior_configuration_id = junior_config_id_params.to_i
    authorize @pole
    if @pole.save
      flash[:success] = "Object successfully created"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @pole = Pole.find(pole_params[:id])
    authorize @pole
    if @pole.update(pole_params)
      flash[:success] = "Object was successfully updated"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def pole_params
    defaults = { archive: false }
    params.require(:pole).permit(:id, :nom)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def junior_config_id_params
    params.require(:junior_configuration_id)
  end
end
