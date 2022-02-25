class PhasesController < ApplicationController
  before_action :authenticate_user!

  def show
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    @campagne_selection = SelectionIntervenant.find_by(phase: @phase.id)
    @new_campagne_selection = SelectionIntervenant.new
    authorize @phase
  end

  def new
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.new
    authorize @phase
  end

  def create
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.new(phase_params)
    @phase.etude = @etude
    authorize @phase
    if @phase.save
      flash[:success] = "Phase successfully created"
      redirect_to junior_etude_path(@junior, @etude)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @phase
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

  def destroy
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    if @phase.destroy
      flash[:success] = 'Phase was successfully deleted.'
      redirect_to junior_etude_path(@junior, @etude)
    else
      flash[:error] = 'Something went wrong'
      redirect_to junior_etude_path(@junior, @etude)
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
