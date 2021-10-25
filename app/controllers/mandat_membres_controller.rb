class MandatMembresController < ApplicationController
  def create
    @mandat = Mandat.new(mandat_params)
    authorize @mandat
    if @mandat.save
      flash[:success] = "Object successfully created"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @mandat = Mandat.find(params[:id])
    authorize @mandat
    if @mandat.update(mandat_params)
      flash[:success] = "Mandat was successfully updated"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def mandat_params
    params.require(:mandat_membre).permit(:pole, :poste, :date_debut, :date_fin)
  end
end
