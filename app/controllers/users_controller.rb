class UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page]
  end
  
  def show
    @user = User.find params[:id]
    @activities = @user.activities.paginate page: params[:page]
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new user_params
    @user.active = true
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      redirect_to @user
    else
      render :edit
    end
  end
  
  private    
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname)
  end
end