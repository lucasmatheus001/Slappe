class User < ApplicationRecord
  has_one_attached :avatar

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # post curtidos por um usuário
  has_many :post_likes, dependent: :destroy
  has_many :liked_posts, through: :post_likes, source: :post

  # comentarios curtidos por um usuário
  has_many :comment_likes, dependent: :destroy
  has_many :liked_comments, through: :comment_likes, source: :comment

  # Um usuário pode seguir muitos outros usuários
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  # Um usuário pode ser seguido por muitos outros usuários
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  # Reposts de postagens
  has_many :reposts, dependent: :destroy
  has_many :reposted_posts, through: :reposts, source: :post

  # enum role: { admin: 2, user: 1 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def following?(other_user)
    following.include?(other_user)
  end
end
