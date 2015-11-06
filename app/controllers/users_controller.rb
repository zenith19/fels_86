class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  def index
    @users = User.paginate page: params[:page]
  end
  
  def show    
    @user = params.has_key?(:id) ? User.find(params[:id]) : current_user 
    @activities = @user.activities.paginate page: params[:page]
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new user_params
    @user.active = true
    if @user.save
      flash[:success] = t '.success'
      log_in @user
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
      flash[:success] = t '.success'
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