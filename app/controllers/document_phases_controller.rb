class DocumentPhasesController < ApplicationController
  def create
    @doc_phase = DocumentPhase.new(document_phase_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_phase
    if @doc_phase.save!
      flash[:success] = "DocumentPhase successfully created"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def update
    @doc_phase = DocumentPhase.find(doc_phase_id_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_phase
    if @doc_phase.update(document_phase_params)
      flash[:success] = "DocumentPhase was successfully updated"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  private

  def document_phase_params
    params.require(:document_phase).permit(:id, :phase_id, :ref_doc, :validite, :date_signature, :nom,
                                           :document)
  end

  def doc_phase_id_params
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
