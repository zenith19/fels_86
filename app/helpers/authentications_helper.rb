module AuthenticationsHelper
  def logged_in_user
    unless logged_in?
      flash[:danger] = t 'sign_in_message'
      redirect_to signin_path
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id    
    end
  end
  
  def log_in user
    session[:user_id] = user.id
    current_user
  end
  
  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def current_user? user
    user == current_user
  end
  
  def check_admin
    redirect_to categories_path unless current_user.admin?
  end  
end