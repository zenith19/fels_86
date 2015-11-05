class Activity < ActiveRecord::Base
  belongs_to :user
  validates :target_id,  presence: true, numericality: { greater_than: 0 }
  validates :action_type,  presence: true, length: { maximum: 255 }  
end
