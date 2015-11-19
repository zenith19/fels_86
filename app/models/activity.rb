class Activity < ActiveRecord::Base
  TYPES = {
    lesson_start: 0,
    lesson_end: 1,
    follow: 2,
    unfollow: 3
  }
  
  belongs_to :user
  validates :target_id,  presence: true, numericality: { greater_than: 0 }
  validates :action_type,  presence: true, length: { maximum: 255 }  
end
