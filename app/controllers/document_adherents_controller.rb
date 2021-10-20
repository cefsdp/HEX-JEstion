class DocumentAdherentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @adherentDocumentParams = document_adherent_params
    @juniorConfigDocAdherent = ConfigDocAdherent.where(junior_configuration_id: JuniorConfiguration.find_by(junior_id: @user.junior_id).id).find_by(nom: @adherentDocumentParams[:nom])
    @documentAdherent = DocumentAdherent.new(adherent_id: @user.adherent.id,
                                             nom: @adherentDocumentParams[:nom],
                                             obligatoire: @juniorConfigDocAdherent.obligatoire,
                                             archive: false,
                                             date_debut_validite: @adherentDocumentParams[:date_debut_validite],
                                             validite: 'pending',
                                             document: @adherentDocumentParams[:document])
    @documentAdherent.date_fin_validite = calcul_date_fin_validite(@documentAdherent)
    authorize @documentAdherent
    if @documentAdherent.save
      flash[:success] = "Object successfully created"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Something went wrong"
      redirect_to edit_user_registration_path
    end
  end

  def update
    @user = current_user
    @adherentDocumentParams = document_adherent_params
    @juniorConfigDocAdherent = ConfigDocAdherent.where(junior_configuration_id: JuniorConfiguration.find_by(junior_id: @user.junior_id).id).find_by(nom: @adherentDocumentParams[:nom])
    @documentAdherent = DocumentAdherent.find(params[:id])
    authorize @documentAdherent
    if @documentAdherent.update(nom: @adherentDocumentParams[:nom],
                                obligatoire: @juniorConfigDocAdherent.obligatoire,
                                archive: false,
                                date_debut_validite: @adherentDocumentParams[:date_debut_validite],
                                date_fin_validite: calcul_date_fin_validite(@documentAdherent),
                                validite: document_adherent_validite_params,
                                document: @adherentDocumentParams[:document])
      flash[:success] = "Object was successfully updated"
      redirect_to junior_adherent_path(@user.junior, @user.adherent)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def document_adherent_params
    params.require(:document_adherent).permit(:nom, :obligatoire, :date_debut_validite, :validite, :archive, :document)
    # validite: pending, valid, invalid
    # Controle Date Validite : .where('date_fin_validite > ?', DateTime.now)
  end

  def document_adherent_validite_params
    params[:validite_document_adherent].nil? ? @adherentDocumentParams[:validite] : params[:validite_document_adherent]
  end

  def calcul_date_fin_validite(document_adh)
    config_doc_adh = document_adh.adherent.user.junior.config_doc_adherents.find_by(nom: document_adh.nom)
    duree_validite = config_doc_adh.duree_validite
    format_duree_validite = config_doc_adh.format_duree_validite
    case format_duree_validite
    when 'an'
      document_adh.date_debut_validite + duree_validite.to_i.year
    when 'mois'
      document_adh.date_debut_validite + duree_validite.to_i.month
    when 'jours'
      document_adh.date_debut_validite + duree_validite.to_i.day
    end
  end
end
