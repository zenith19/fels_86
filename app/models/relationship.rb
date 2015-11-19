class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id,  presence: true
  validates :followed_id,  presence: true
  
  after_create :log_activity_for_follow
  after_destroy :log_activity_for_unfollow
  
  def log_activity_for_follow
    Activity.create target_id: followed_id, user_id: follower_id, action_type: Activity::TYPES[:follow]
  end
  
  def log_activity_for_unfollow
    Activity.create target_id: followed_id, user_id: follower_id, action_type: Activity::TYPES[:unfollow]
  end  
end
