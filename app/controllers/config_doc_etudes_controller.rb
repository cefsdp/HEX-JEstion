class ConfigDocEtudesController < ApplicationController
  before_action :authenticate_user!

  def create
    @configDocEtude = ConfigDocEtude.new(configdocetude_params)
    authorize @configDocEtude
    if @configDocEtude.save!
      flash[:success] = "Object successfully created"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    end
  end

  def update
    @configDocEtude = ConfigDocEtude.find(configdocetude_params[:id])
    authorize @configDocEtude
    if @configDocEtude.update(configdocetude_params)
      flash[:success] = "Object was successfully updated"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    end
  end

  private

  def configdocetude_params
    defaults = { archive: false }
    params.require(:config_doc_etude).permit(:id, :junior_configuration_id, :nom, :obligatoire, :type_doc, :interne,
                                             :archive, :document_type).reverse_merge(defaults)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def junior_config_id_params
    params.require(:junior_configuration_id)
  end
end
