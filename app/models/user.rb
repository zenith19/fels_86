class User < ActiveRecord::Base
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :lessons, dependent: :destroy
  has_many :words, through: :lessons
  has_many :activities, dependent: :destroy
  scope :not_learned_ids, ->(user, category) do
    learned_words_sql = User.where(id: user.id).joins(:words)
      .select('"words"."id"').to_sql
    Word.where(category_id: category.id).where.not("id IN (#{learned_words_sql})")
      .ids.sample(20)
  end
    
  validates :firstname,  presence: true, length: { maximum: 30 }
  validates :lastname,  presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  
  before_save :downcase_email
  has_secure_password
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  private    
  def downcase_email
    self.email = email.downcase
  end
end
