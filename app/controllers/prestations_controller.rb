class PrestationsController < ApplicationController
    before_action :authenticate_user!

    def create
      @prestation = Prestation.new(prestation_params)
      @prestation.junior_configuration_id = junior_config_id_params.to_i
      authorize @prestation
      if @prestation.save
        flash[:success] = "Object successfully created"
        redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
      else
        flash[:error] = "Something went wrong"
        render 'new'
      end
    end
  
    def update
      @prestation = Prestation.find(prestation_params[:id])
      authorize @prestation
      if @prestation.update(prestation_params)
        flash[:success] = "Object was successfully updated"
        redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
    end

    
  private

  def prestation_params
    defaults = { archive: false }
    params.require(:prestation).permit(:id, :nom)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def junior_config_id_params
    params.require(:junior_configuration_id)
  end
end
