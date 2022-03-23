class SelectionIntervenantsController < ApplicationController
  def index
    @selections = policy_scope(SelectionIntervenant)
    @selections_actifs = @selections.where(active: true)
    @selections_inactif = @selections.where(active: true)
    @new_postulant = Postulant.new
    @junior = Junior.find(junior_id_params.to_i)
  end

  def mes_missions
    @mes_missions = current_user.intervenants
    @junior = Junior.find(junior_id_params.to_i)
  end

  def create
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    @selection = SelectionIntervenant.new(selection_params)
    authorize @selection
    if @selection.save
      flash[:success] = "SelectionIntervenant successfully created"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def update
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    @selection = SelectionIntervenant.find(selection_id_params)
    authorize @selection
    if @selection.update(selection_params)
      flash[:success] = "SelectionIntervenant was successfully updated"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def destroy
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    @selection = SelectionIntervenant.find(selection_id_params)
    authorize @selection
    if @selection.destroy
      flash[:success] = 'SelectionIntervenant was successfully deleted.'
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = 'Something went wrong'
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  private

  def selection_params
    params.require(:selection_intervenant).permit!
  end

  def selection_id_params
    params[:id]
  end

  def phase_id_params
    params[:phase_id]
  end

  def etude_id_params
    params[:etude_id]
  end

  def junior_id_params
    params[:junior_id]
  end
end
