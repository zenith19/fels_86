class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words
  accepts_nested_attributes_for :lesson_words
  validates :result, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :check_lesson_words_number
  before_update :update_result
  
  def update_result
    result = lesson_words.select do |lesson_word|
      lesson_word.word_answer.correct?
    end.count
  end
  
  def number_of_words_is_valid?
    lesson_words.length > 0
  end
  
  def check_lesson_words_number
    unless number_of_words_is_valid?
      errors.add :base, I18n.t(:check_lesson_words_number_error)
    end
  end
end