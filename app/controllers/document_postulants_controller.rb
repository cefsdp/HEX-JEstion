class DocumentPostulantsController < ApplicationController
  def create
    @doc_postulant = DocumentPostulant.new(document_postulant_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_postulant
    if @doc_postulant.save!
      flash[:success] = "DocumentPostulant successfully created"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def update
    @doc_postulant = DocumentPostulant.find(doc_postulant_id_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_postulant
    if @doc_postulant.update(document_postulant_params)
      flash[:success] = "DocumentPostulant was successfully updated"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  private

  def document_postulant_params
    params.require(:document_postulant).permit(:id, :postulant_id, :ref_doc, :validite, :date_signature, :nom,
                                               :document)
  end

  def doc_postulant_id_params
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
