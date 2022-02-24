class PhasesController < ApplicationController
  before_action :authenticate_user!

  def create
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.new(phase_params)
    authorize @phase
    if @phase.save
      flash[:success] = "Phase successfully created"
      redirect_to junior_etude_path(@junior, @etude)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @phase
    if @phase.update(phase_params)
      flash[:success] = "Phase was successfully updated"
      redirect_to junior_etude_path(@junior, @etude)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def phase_params
    params.require(:phase).permit!
  end

  def phase_id_params
    params[:id]
  end

  def etude_id_params
    params[:etude_id]
  end

  def junior_id_params
    params[:junior_id]
  end
end
