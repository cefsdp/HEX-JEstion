class JuniorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @juniors = policy_scope(Junior)
  end

  def show
    @junior = Junior.find(params[:id])
    authorize @junior
    file_status = check_adherent_document_validity
    raise
  end

  def new
    @junior = Junior.new
    authorize @junior
  end

  def create
    @junior = Junior.new(junior_params)
    authorize @junior
    if @junior.save
      @user = User.new(email: "admin@#{@junior.nom}.fr", password: "adminadmin", password_confirmation: "adminadmin",
                       junior_id: @junior.id, admin: false)
      @user.save
      @configuration = Configuration.create(junior_id: @junior.id)
      flash[:success] = "Junior successfully created"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @junior = Junior.find(params[:id])
    authorize @junior
  end

  def update
    @junior = Junior.find(params[:id])
    authorize @junior
    if @junior.update(junior_params)
      flash[:success] = "Junior was successfully updated"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    @junior = Junior.find(params[:id])
    authorize @junior
    if @junior.destroy
      flash[:success] = 'Junior was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to juniors_url
  end

  private

  def junior_params
    params.require(:junior).permit(:nom, :codeje, :logo)
  end

  def check_adherent_document_validity
    necessary_documents = ConfigDocAdherent.where(junior_configuration_id: JuniorConfiguration.where(junior_id: current_user.junior))
    adherent_documents = DocumentAdherent.where(adherent_id: current_user.adherent.id, validite: ['valid', 'pending'])
    file_status = nil
    necessary_documents.each do |nec_doc|
      if adherent_documents.where(nom: nec_doc.nom).empty?
        return file_status = 'invalid'
      else
        adherent_documents.where(nom: nec_doc.nom).each do |doc|
          case doc.validite
          when 'valid'
            case file_status
            when nil
              file_status = 'valid'
            when 'valid'
              file_status = 'valid'
            when 'pending'
              file_status = 'pending'
            when 'invalid'
              file_status = 'invalid'
            end
          when 'pending'
            if [nil, 'valid', 'pending'].include?(file_status)
              file_status = 'pending'
            elsif file_status == 'invalid'
              file_status = 'invalid'
            end
          end
        end
      end
    end
    return file_status
  end
end
