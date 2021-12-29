class MandatRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @mandat_request = MandatRequest.new(poste: Poste.find(mandat_request_params[:poste].to_i),
                                        pole: Pole.find(mandat_request_params[:pole].to_i),
                                        date_debut: mandat_request_params[:date_debut],
                                        date_fin: mandat_request_params[:date_fin],
                                        status: mandat_request_params[:status])
    @mandat_request.membre_id = membre_id_params.to_i
    authorize @mandat_request
    if @mandat_request.save
      flash[:success] = "Object successfully created"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @mandat_request = MandatRequest.find(mandat_request_params[:id])
    authorize @mandat_request
    if @mandat_request.update(poste: Poste.find(mandat_request_params[:poste].to_i),
                              pole: Pole.find(mandat_request_params[:pole].to_i),
                              date_debut: mandat_request_params[:date_debut],
                              date_fin: mandat_request_params[:date_fin],
                              status: mandat_request_params[:status])
      flash[:success] = "Object was successfully updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def mandat_request_params
    defaults = { status: 'pending' }
    params.require(:mandat_request).permit(:id, :poste, :pole, :date_debut, :date_fin,
                                           :status).reverse_merge(defaults)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def membre_id_params
    params.require(:membre_id)
  end
end
