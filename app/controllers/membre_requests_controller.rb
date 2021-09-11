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
    @membrerequest = MembreRequest.find(params[:id])
    authorize @membrerequest
    if @membrerequest.update(membrerequest_params)
      check_membership
      flash[:success] = "MembreRequest was successfully updated"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  private

  def membrerequest_params
    params.require(:membre_request).permit(:junior, :user, :status)
  end

  def check_membership
    case @membrerequest.status
    when 'rejected'
      @membre_request.destroy
    when 'approved'
      @membre = Membre.create(membre_request_id: @membre_request.id, admin: false)
    end
  end
end
