class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  has_many :lesson_words, dependent: :destroy
  accepts_nested_attributes_for :word_answers, allow_destroy: true
  validates :content,  presence: true
  validates :category,  presence: true
end