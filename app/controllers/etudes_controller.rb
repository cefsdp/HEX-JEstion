class EtudesController < ApplicationController
  before_action :authenticate_user!

  def index
    @etudes = policy_scope(Etude)
  end

  def show
    @etude = Etude.find(params[:id])
    authorize @etude
  end

  def new
    @junior = Junior.find(junior_id_params)
    @etude = Etude.new
    authorize @etude
    @new_reference = new_ref_calculation
  end

  def create
    @junior = Junior.find(junior_id_params)
    @etude = Etude.new(etude_params)
    authorize @etude
    if @etude.save
      flash[:success] = "Object successfully created"
      redirect_to @etude
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(params[:id])
  end

  private

  def etude_params
    params.require(:etude).permit(:id, :ref_etude, :statut, :date_debut, :charge_qualite_id, :charge_rh_id,
                                  :charge_etude_id, :client_id, :prestation_id, :confidentielle, :date_signature)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def new_ref_calculation
    if @etudes.nil?
      Date.today.strftime("%y") + "001"
    else
      if @etudes.order(:ref_etude).last
        @etudes.order(:ref_etude).last.ref_etude.to_i + 1
      else
        Date.today.strftime("%y") + "001"
      end
    end
  end
end
