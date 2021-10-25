class PolesController < ApplicationController
  def create
    @pole = Pole.new(pole_params)
    @pole.junior_id = params[:junior_id]
    authorize @pole
    if @pole.save
      flash[:success] = "Object successfully created"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    @pole = Pole.find(pole_params[:id])
    authorize @pole
    if @pole.update(pole_params)
      flash[:success] = "Pole was successfully updated"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def pole_params
    defaults = { archive: false }
    params.require(:pole).permit(:id, :nom, :archive).reverse_merge(defaults)
  end
end
