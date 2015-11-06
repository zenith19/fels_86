class WordAnswer < ActiveRecord::Base
  belongs_to :word
  has_many :lesson_words, dependent: :destroy  
  validates :content,  presence: true
  validates :correct,  presence: true
end
