class Admin::UsersController < ApplicationController
  include UsersHelper
  before_action :logged_in_user
  before_action :create_user, except: [:index, :show]
  before_action :create_user_or_current_user, only: :show 
  
  def index
    @users = User.paginate page: params[:page]
  end
  
  def show     
    @activities = @user.activities.paginate page: params[:page]
  end
  
  def edit    
  end
  
  def update    
    if @user.update_attributes user_params
      flash[:success] = t '.success'
      redirect_to @user
    else
      render :edit
    end
  end
  
  private    
  def user_params
    params.require(:user).permit :email, :password, :password_confirmation, :firstname, :lastname
  end  
end