class AuthenticationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:authentication][:email]
    if user && (user.authenticate params[:authentication][:password])
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = t '.danger'
      render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end