class Word < ActiveRecord::Base
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  has_many :lesson_words, dependent: :destroy
  accepts_nested_attributes_for :word_answers, allow_destroy: true
  validates :content,  presence: true
  validates :category,  presence: true
  scope :except_these, ->(ids) { where.not id: ids }
  scope :find_word_objects, ->(category) { where(category_id: category.id) }
  scope :not_learn_all_categories, ->(user) do
    learned_words_sql = User.where(id: user.id).joins(:words).select('"words"."id"').to_sql
    Word.where.not("id IN (#{learned_words_sql})")
  end
  scope :not_learned_specific_category, ->(user, category) do
    learned_words_sql = User.where(id: user.id).joins(:words).select('"words"."id"').to_sql
    Word.where(category_id: category.id).where.not("id IN (#{learned_words_sql})")
  end
end