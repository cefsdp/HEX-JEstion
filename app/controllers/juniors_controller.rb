class JuniorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @juniors = policy_scope(Junior)
  end

  def show
    @junior = Junior.find(params[:id])
    authorize @junior
  end

  def new
    @junior = Junior.new
    authorize @junior
  end

  def create
    @junior = Junior.new(junior_params)
    authorize @junior
    if @junior.save
      @user = User.new(email: "admin@#{@junior.nom}.fr", password: "adminadmin", password_confirmation: "adminadmin",
                       junior_id: @junior.id, admin: false)
      @user.save
      @configuration = Configuration.create(junior_id: @junior.id)
      flash[:success] = "Junior successfully created"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @junior = Junior.find(params[:id])
    authorize @junior
  end

  def update
    @junior = Junior.find(params[:id])
    authorize @junior
    if @junior.update(junior_params)
      flash[:success] = "Junior was successfully updated"
      redirect_to @junior
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    @junior = Junior.find(params[:id])
    authorize @junior
    if @junior.destroy
      flash[:success] = 'Junior was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to juniors_url
  end

  private

  def junior_params
    params.require(:junior).permit(:nom, :codeje, :logo)
  end
end
