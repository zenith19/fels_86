class AuthenticationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:authentication][:email]
    if user && (user.authenticate params[:authentication][:password])
      log_in user
      redirect_home
    else
      flash.now[:danger] = t '.danger'
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to new_authentication_path
  end
  
  private
  def redirect_home
    redirect_to (current_user.admin?) ? admin_root_path : root_url
  end
end