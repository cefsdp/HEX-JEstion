class ClientsController < ApplicationController
  def index
    @Clients = policy_scope(Client)
  end

  def new
    @new_client = Client.new
    @etude = Etude.find(params[:etude_id].to_i)
    @junior = Junior.find(params[:junior_id].to_i)
    authorize @new_client
    @types_entreprises = JuniorConfiguration.find_by(junior_id: @junior.id).types_entreprises
    @provenances_clients = JuniorConfiguration.find_by(junior_id: @junior.id).provenances_clients
    @methodes_premier_contact = JuniorConfiguration.find_by(junior_id: @junior.id).methodes_premier_contact
  end

  def create
    @client = Client.new(client_params)
    @etude = Etude.find(params[:etude][:id].to_i)
    @junior = Junior.find(params[:junior_id].to_i)
    @client.junior = @junior
    authorize @client
    if @client.save!
      if @etude.nil?
        flash[:success] = "Client successfully created"
        redirect_to @client
      else
        @etude.client = @client
        @etude.save
        flash[:success] = "Client successfully created"
        redirect_to junior_etude_path(@junior, @etude)
      end
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @client = Client.find(params[:id].to_i)
    @junior = Junior.find(params[:junior_id].to_i)
    authorize @client
    @types_entreprises = JuniorConfiguration.find_by(junior_id: @junior.id).types_entreprises
    @provenances_clients = JuniorConfiguration.find_by(junior_id: @junior.id).provenances_clients
    @methodes_premier_contact = JuniorConfiguration.find_by(junior_id: @junior.id).methodes_premier_contact
  end

  def update
    @client = Client.find(params[:id])
    @junior = Junior.find(params[:junior_id].to_i)
    authorize @client
    if @client.update(client_params)
      flash[:success] = "Client was successfully updated"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def client_params
    params.require(:client).permit(:sexe, :prenom, :nom, :telephone, :email, :langue,
                                   :entreprise, :siret, :type_entreprise, :activite, :telephone_entreprise,
                                   :site_web, :adresse, :code_postal, :ville, :pays, :poste,
                                   :provenance, :premier_contact)
  end
end
