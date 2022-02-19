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
    @etude = Etude.new
    @client = Client.new
  end

  def create
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
    @etude = Etude.find(params[:id])
  end

  private

  def etude_params
    params.require(:etude).permit(:id, :ref_etude, :statut, :date_debut, :charge_qualite_id, :charge_rh_id,
                                  :charge_etude_id, :client_id, :prestation_id)
  end
end
