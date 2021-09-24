class ConfigDocAdherentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @configDocAdherent = ConfigDocAdherent.new(configdocadherent_params)
    @configDocAdherent.junior_configuration_id = junior_config_id_params.to_i
    authorize @configDocAdherent
    if @configDocAdherent.save
      flash[:success] = "Object successfully created"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      raise
      flash[:error] = "Something went wrong"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    end
  end

  private

  def configdocadherent_params
    params.require(:config_doc_adherent).permit(:nom, :obligatoire, :duree_validite, :format_duree_validite,
                                                archive: false)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def junior_config_id_params
    params.require(:junior_configuration_id)
  end
end
