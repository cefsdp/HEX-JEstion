class DocumentIntervenantsController < ApplicationController
  def create
    @doc_intervenant = DocumentIntervenant.new(document_intervenant_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_intervenant
    if @doc_intervenant.save!
      flash[:success] = "Documentintervenant successfully created"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  def update
    @doc_intervenant = DocumentIntervenant.find(doc_intervenant_id_params)
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    authorize @doc_intervenant
    if @doc_intervenant.update(document_intervenant_params)
      flash[:success] = "Documentintervenant was successfully updated"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    else
      flash[:error] = "Something went wrong"
      redirect_to junior_etude_phase_path(@junior, @etude, @phase)
    end
  end

  private

  def document_intervenant_params
    params.require(:document_intervenant).permit(:id, :intervenant_id, :ref_doc, :validite, :date_signature, :nom,
                                                 :document)
  end

  def doc_intervenant_id_params
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
