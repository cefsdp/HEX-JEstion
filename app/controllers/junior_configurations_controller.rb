class JuniorConfigurationsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @junior = Junior.find(params[:junior_id])
    @configuration = JuniorConfiguration.find(params[:id])
    @configDocAdherent = ConfigDocAdherent.new
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

  private

  def configuration_params
    params.require(:junior_configuration).permit(:id, niveau_etude: [], specialisation_etude: [])
  end
end
