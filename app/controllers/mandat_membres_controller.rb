class MandatMembresController < ApplicationController
  def create
    @mandat = Mandat.new(mandat_params)
    if @mandat.save
      flash[:success] = "Object successfully created"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @mandat = Mandat.find(params[:id])
    if @mandat.update_attributes(mandat_params)
      flash[:success] = "Mandat was successfully updated"
      redirect_to @mandat
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
