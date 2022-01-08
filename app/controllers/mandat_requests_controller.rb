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
    @mandat_request = MandatRequest.find(update_mandat_request_id_params)
    authorize @mandat_request
    if @mandat_request.update(status: mandat_request_params[:status])
      check_mandatship
      flash[:success] = "Mandat Request was successfully updated"
      redirect_to junior_membres_path(@junior)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    @junior = current_user.junior
    @mandat_request = MandatRequest.find(params[:id])
    authorize @mandat_request
    if @mandat_request.destroy
      flash[:success] = 'MandatRequest was successfully deleted.'
      redirect_to junior_membres_path(@junior)
    else
      flash[:error] = 'Something went wrong'
      redirect_to junior_membres_path(@junior)
    end
  end

  private

  def mandat_request_params
    defaults = { status: 'pending' }
    params.require(:mandat_request).permit(:id, :poste, :pole, :date_debut, :date_fin,
                                           :status).reverse_merge(defaults)
  end

  def update_mandat_request_id_params
    params.require(:id)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def membre_id_params
    params.require(:membre_id)
  end

  def permission_params
    params.require(:permission).permit(:id)
  end

  def check_mandatship
    case @mandat_request.status
    when 'rejected'
      @mandat_request.destroy
    when 'approved'
      @mandat = Mandat.create(mandat_request_id: @mandat_request.id, permission_id: permission_params[:id].to_i)
    end
  end
end
