class IntervenantsController < ApplicationController
  def create
    @intervenant = Intervenant.new(intervenant_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @intervenant
    if @intervenant.save
      flash[:success] = "Intervenant successfully created"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def update
    @intervenant = Intervenant.find(intervenant_id_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @intervenant
    if @intervenant.update(intervenant_params)
      flash[:success] = "Intervenant was successfully updated"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def destroy
    @intervenant = Intervenant.find(intervenant_id_params)
    authorize @intervenant
    if @intervenant.destroy
      flash[:success] = 'Intervenant was successfully deleted.'
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = 'Something went wrong'
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  private

  def intervenant_params
    params.require(:intervenant).permit!
  end

  def intervenant_id_params
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
