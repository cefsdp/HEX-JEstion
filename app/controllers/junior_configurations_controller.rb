class JuniorConfigurationsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @junior = Junior.find(params[:junior_id])
    @configuration = JuniorConfiguration.find(params[:id])
    @newConfigDocAdherent = ConfigDocAdherent.new
    @configDocAdherents = @configuration.config_doc_adherents.where(archive: false).order(id: 'ASC')
    @poles = Pole.where(junior_id: @junior.id, archive: false)
    @new_pole = Pole.new
    @postes = Poste.where(junior_id: @junior.id, archive: false)
    @new_poste = Poste.new
    @permissions = PermissionMembre.where(junior_id: @junior.id)
    @new_permission = PermissionMembre.new
    authorize @configuration
  end

  def update
    @junior = Junior.find(params[:junior_id])
    @configuration = JuniorConfiguration.find(params[:id])
    authorize @configuration
    @params = configuration_params
    if @configuration.update(@params)
      flash[:success] = "Configuration was successfully updated"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def archives
    @junior = Junior.find(params[:junior_id])
    @configuration = JuniorConfiguration.find(params[:junior_configuration_id])
    authorize @configuration
    @configDocAdherents = @configuration.config_doc_adherents.where(archive: true).order(id: 'ASC')
    @poles = Pole.where(junior_id: @junior.id, archive: true)
    @postes = Poste.where(junior_id: @junior.id, archive: true)
  end

  private

  def configuration_params
    params.require(:junior_configuration).permit(:id, niveau_etude: [], specialisation_etude: [])
  end
end
