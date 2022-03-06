class DocumentEtudesController < ApplicationController
  def create
    @doc_etude = DocumentEtude.new(document_etude_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_etude
    if @doc_etude.save!
      flash[:success] = "Documentetude successfully created"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def update
    @doc_etude = DocumentEtude.find(doc_etude_id_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_etude
    if @doc_etude.update(document_etude_params)
      flash[:success] = "Documentetude was successfully updated"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  private

  def document_etude_params
    params.require(:document_etude).permit(:id, :etude_id, :ref_doc, :validite, :date_signature, :nom,
                                           :document)
  end

  def doc_etude_id_params
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
