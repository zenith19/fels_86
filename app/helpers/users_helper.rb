module UsersHelper
  def create_user
    @user = User.find params[:id]
  end
  
  def create_user_or_current_user
    @user = params.has_key?(:id) ? User.find(params[:id]) : current_user
  end
end