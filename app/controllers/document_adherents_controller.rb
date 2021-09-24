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
    authorize @documentAdherent
    if @documentAdherent.save
      flash[:success] = "Object successfully created"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Something went wrong"
      redirect_to edit_user_registration_path
    end
  end

  private

  def document_adherent_params
    params.require(:document_adherent).permit(:nom, :obligatoire, :date_debut_validite, :validite, :archive, :document)
    # validite: pending, valid, invalid
  end
end
