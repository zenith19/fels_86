class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent :destroy
  has_many :lesson_words, dependent :destroy
  validates :content,  presence: true
end
