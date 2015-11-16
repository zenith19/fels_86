class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_words, dependent: :destroy
  accepts_nested_attributes_for :lesson_words
  validates :result,  presence: true, numericality: { greater_than_or_equal_to: 0 }
  before_update :update_result
  
  def update_result
    result = lesson_words.select do |lesson_word|
      lesson_word.word_answer.correct?
    end.count
  end
end