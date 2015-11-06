class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_words, dependent: :destroy
  validates :result,  presence: true, numericality: { greater_than_or_equal_to: 0 }
end
