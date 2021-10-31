class MembreRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @membrerequests = policy_scope(MembreRequest)
  end

  def new
    @membrerequest = MembreRequest.new
  end

  def create
    @membrerequest = MembreRequest.new(junior: Junior.find(membrerequest_params[:junior]),
                                       user: User.find(membrerequest_params[:user]))
    @membrerequest.status = 'pending'
    authorize @membrerequest
    if @membrerequest.save
      flash[:success] = "MembreRequest successfully created"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @membrerequest = MembreRequest.find(params[:id])
  end

  def update
    @junior = current_user.junior
    @membre_request = MembreRequest.find(params[:id])
    authorize @membre_request
    if @membre_request.update(membrerequest_params)
      check_membership
      flash[:success] = "MembreRequest was successfully updated"
      redirect_to junior_membres_path(@junior)
    else
      flash[:error] = "Something went wrong"
      render junior_membres_path(@junior)
    end
  end

  def destroy
    @junior = current_user.junior
    @membrerequest = MembreRequest.find(params[:id])
    authorize @membrerequest
    if @membrerequest.destroy
      flash[:success] = 'MembreRequest was successfully deleted.'
      redirect_to junior_membres_path(@junior)
    else
      flash[:error] = 'Something went wrong'
      redirect_to junior_membres_path(@junior)
    end
  end

  private

  def membrerequest_params
    params.require(:membre_request).permit(:junior, :user, :status)
  end

  def check_membership
    case @membre_request.status
    when 'rejected'
      @membre_request.destroy
    when 'approved'
      @membre = Membre.create(membre_request_id: @membre_request.id, admin: false)
    end
  end
end
