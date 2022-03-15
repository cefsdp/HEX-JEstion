class PhasesController < ApplicationController
  before_action :authenticate_user!

  def show
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.find(phase_id_params)
    @campagne_selection = SelectionIntervenant.find_by(phase: @phase.id)
    @new_campagne_selection = SelectionIntervenant.new
    @config_specialisation_etude = JuniorConfiguration.find_by(junior_id: @junior.id).specialisation_etude
    @config_niveau_etude = JuniorConfiguration.find_by(junior_id: @junior.id).niveau_etude
    @config_docs_junior = @junior.junior_configuration.config_doc_adherents
    @new_intervenant = Intervenant.new
    @intervenants = Intervenant.where(phase_id: @phase.id).order(ref_rm: :asc)
    @campagne_selection.nil? ? @postulants_doc_controlled = "" : @postulants_doc_controlled = postulants_doc_controller(@campagne_selection.postulants)
    authorize @phase
  end

  def new
    @junior = Junior.find(junior_id_params)
    @etude = Etude.find(etude_id_params)
    @phase = Phase.new
    @config_specialisation_etude = JuniorConfiguration.find_by(junior_id: @junior.id).specialisation_etude
    @config_niveau_etude = JuniorConfiguration.find_by(junior_id: @junior.id).niveau_etude
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
    @config_specialisation_etude = JuniorConfiguration.find_by(junior_id: @junior.id).specialisation_etude
    @config_niveau_etude = JuniorConfiguration.find_by(junior_id: @junior.id).niveau_etude
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

  def postulants_doc_controller(postulants)
    all_postulants_docs = []
    postulants.each do |postulant|
      postulant_docs = { postulant: postulant.id, documents: [] }
      @config_docs_junior.each do |doc_config|
        if postulant.user.adherent.document_adhesions.where(nom: doc_config.nom,
                                                            validite: ['valid', 'pending']).count.zero?
          postulant_docs[:documents] << { nom: doc_config.nom, validite: "invalid" }
        else
          a_tester = postulant.user.adherent.document_adhesions.where(nom: doc_config.nom,
                                                                      validite: ['valid', 'pending'])
          if test_date_documents(a_tester).count.zero?
            postulant_docs[:documents] << { nom: doc_config.nom, validite: "invalid" }
          elsif test_date_documents(a_tester).find_by(validite: "valid")
            postulant_docs[:documents] << { nom: doc_config.nom, validite: "valid" }
          elsif test_date_documents(a_tester).find_by(validite: "pending")
            postulant_docs[:documents] << { nom: doc_config.nom, validite: "pending" }
          end
        end
      end
      all_postulants_docs << postulant_docs
    end
    return all_postulants_docs
  end

  def test_date_documents(docs)
    docs.where('date_debut_validite < :date_debut AND date_fin_validite > :date_fin', date_debut: @phase.date_debut,
                                                                                      date_fin: @phase.date_fin)
  end
end
