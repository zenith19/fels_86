class LessonWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer
  scope :unanswered, -> {where word_answer_id: nil }
end
