class PostulantsController < ApplicationController
  def create
    @postulant = Postulant.new(postulants_params)
    @campagne = SelectionIntervenant.find(selection_id_params.to_i)
    @junior = Junior.find(junior_id_params.to_i)
    authorize @postulant
    if @postulant.save
      flash[:success] = "Postulant successfully created"
      redirect_to junior_selection_intervenants_path(@junior.id)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_selection_intervenants_path(@junior.id)
    end
  end

  def update
    @postulant = Postulant.find(postulant_id_params)
    if @postulant.update(postulants_params)
      flash[:success] = "Postulant was successfully updated"
      redirect_to junior_selection_intervenants_path(@junior.id)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_selection_intervenants_path(@junior.id)
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
    params[:phase_id]
  end

  def etude_id_params
    params[:etude_id]
  end

  def junior_id_params
    params[:junior_id]
  end
end
