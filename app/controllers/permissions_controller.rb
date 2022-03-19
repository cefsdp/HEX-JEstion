class PermissionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @permission = Permission.new()
    @junior_configuration = JuniorConfiguration.find(junior_config_id_params.to_i)
    @junior = Junior.find(junior_id_params.to_i)
    authorize @permission
  end
  
  def create
    @permission = Permission.new(permission_params)
    @permission.junior_configuration_id = junior_config_id_params.to_i
    authorize @permission
    if @permission.save
      flash[:success] = "Object successfully created"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @permission = Permission.find(permission_id_params.to_i)
    @junior_configuration = JuniorConfiguration.find(junior_config_id_params.to_i)
    @junior = Junior.find(junior_id_params.to_i)
    authorize @permission
  end

  def update
    @permission = Permission.find(permission_id_params.to_i)
    authorize @permission
    if @permission.update(permission_params)
      flash[:success] = "Object was successfully updated"
      redirect_to edit_junior_junior_configuration_path(junior_id_params, junior_config_id_params)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def permission_params
    defaults = { archive: false }
    params.require(:permission).permit!
  end

  def permission_id_params
    params.require(:id)
  end

  def junior_id_params
    params.require(:junior_id)
  end

  def junior_config_id_params
    params.require(:junior_configuration_id)
  end
end
