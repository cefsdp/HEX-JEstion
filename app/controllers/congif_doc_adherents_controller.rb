class CongifDocAdherentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @configDocAdherent = ConfigDocAdherent.new(params[:ConfigDocAdherent])
    authorize @configDocAdherent
    if @configDocAdherent.save
      flash[:success] = "Object successfully created"
      redirect_to @configDocAdherent
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
end
