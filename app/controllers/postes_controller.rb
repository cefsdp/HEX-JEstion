class PostesController < ApplicationController
  before_action :authenticate_user!

  def create
    @poste = Poste.new(poste_params)
    @poste.junior_configuration_id = junior_config_id_params.to_i
    authorize @poste
    if @poste.save
      flash[:success] = "Object successfully created"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @poste = Poste.find(poste_params[:id])
    authorize @poste
    if @poste.update(poste_params)
      flash[:success] = "Object was successfully updated"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def poste_params
    defaults = { archive: false }
    params.require(:poste).permit(:id, :nom)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def junior_config_id_params
    params.require(:junior_configuration_id)
  end
end
