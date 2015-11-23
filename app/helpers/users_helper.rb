module UsersHelper
  def create_user
    @user = User.find params[:id]
  end
  
  def create_user_or_current_user
    @user = params.has_key?(:id) ? User.find(params[:id]) : current_user
  end
  
  def load_activity_messages activities
    messages = []
    activities.each do |activity|
      activity_date = activity.created_at.strftime("%F")        
      if activity.action_type == Activity::TYPES[:lesson_start] || 
        activity.action_type == Activity::TYPES[:lesson_end]
        lesson = Lesson.find activity.target_id
        category_name = lesson.category.name
        if activity.action_type == Activity::TYPES[:lesson_start]
          messages.push(I18n.t(:activity_start_lesson, 
            category_name: "#{category_name}", date: "#{activity_date}"))
        else
          messages.push(I18n.t(:activity_end_lesson, 
            category_name: "#{category_name}", date: "#{activity_date}"))
        end
      else
        followed_user = User.find activity.target_id
        followed_user_name = followed_user.firstname+" "+followed_user.lastname
        if activity.action_type == Activity::TYPES[:follow] 
          messages.push(I18n.t(:activity_follow_user, 
            user_name: "#{followed_user_name}",date: "#{activity_date}"))
        else
          messages.push(I18n.t(:activity_unfollow_user, 
            user_name: "#{followed_user_name}",date: "#{activity_date}"))
        end
      end      
    end
    messages
  end  
  
end