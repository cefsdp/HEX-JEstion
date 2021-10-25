class PostesController < ApplicationController
  def create
    @poste = Poste.new(poste_params)
    @poste.junior_id = params[:junior_id]
    authorize @poste
    if @poste.save
      flash[:success] = "Object successfully created"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @poste = Poste.find(poste_params[:id])
    authorize @poste
    if @poste.update(poste_params)
      flash[:success] = "Poste was successfully updated"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def poste_params
    defaults = { archive: false }
    params.require(:poste).permit(:id, :nom, :archive).reverse_merge(defaults)
  end
end
