class PostulantsController < ApplicationController
  def create
    @postulant = Postulant.new(postulants_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    @campagne = SelectionIntervenant.find(selection_id_params.to_i)
    authorize @postulant
    if @postulant.save
      flash[:success] = "Postulant successfully created"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def update
    @postulant = Postulant.find(postulant_id_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @postulant
    if @postulant.update(postulants_params)
      flash[:success] = "Postulant was successfully updated"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  private

  def postulants_params
    params.require(:postulant).permit!
  end

  def postulant_id_params
    params[:id]
  end

  def selection_id_params
    params[:selection_intervenant_id]
  end

  def phase_id_params
    SelectionIntervenant.find(selection_id_params).phase.id
  end

  def etude_id_params
    SelectionIntervenant.find(selection_id_params).phase.etude.id
  end

  def junior_id_params
    params[:junior_id]
  end
end
