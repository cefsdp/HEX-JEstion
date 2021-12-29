class MandatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @mandat = Mandat.new(permission: Permission.find(mandat_request_params[:permission].to_i))
    @mandat.mandat_request_id = mandat_request_id_params.to_i
    authorize @mandat
    if @mandat.save
      flash[:success] = "Object successfully created"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @mandat = Mandat.find(mandat_params[:id])
    authorize @mandat
    if @mandat.update(permission: Permission.find(mandat_request_params[:permission].to_i))
      flash[:success] = "Object was successfully updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def mandat_params
    params.require(:mandat).permit(:id, :permission)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def mandat_request_id_params
    params.require(:mandat_request_id)
  end
end
