class AdherentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @adherents = policy_scope(Adherent)
  end

  def show
    @adherent = Adherent.find(params[:id])
    authorize @adherent
    @user = @adherent.user
    @junior = @user.junior
    @document = DocumentAdherent.new
    @documents = DocumentAdherent.where(adherent_id: @adherent.id).order(
      "nom ASC", "date_fin_validite DESC"
    )
    @configuration_id = JuniorConfiguration.find_by(junior_id: @junior.id)
    @document_obligatoires = ConfigDocAdherent.where(junior_configuration_id: @configuration_id, obligatoire: true)
  end

  def edit
    @adherent = Adherent.find(params[:adherent_id])
    @junior = @adherent.user.junior
    authorize @adherent
  end

  def update
    @adherent = Adherent.find(params[:id])
    authorize @adherent
    if @adherent.update(adherent_params)
      flash[:success] = "Object was successfully updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def adherent_params
    params.require(:adherent).permit(:id, :nom, :prenom, :telephone, :adresse_postale, :code_postale, :ville,
                                     :niveau_etude, :annee_diplome, :specialisation_etude, :avatar)
  end
end
