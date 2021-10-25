class PermissionMembresController < ApplicationController
  def create
    @permissionMembre = PermissionMembre.new(permissionMembre_params)
    @permissionMembre.junior_id = params[:junior_id]
    authorize @permissionMembre
    if @permissionMembre.save
      flash[:success] = "Object successfully created"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @permissionMembre = PermissionMembre.find(permissionMembre_params[:id])
    authorize @permissionMembre
    if @permissionMembre.update(permissionMembre_params)
      flash[:success] = "PermissionMembre was successfully updated"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def permissionMembre_params
    params.require(:permission_membre).permit(:id, :nom)
  end
end
