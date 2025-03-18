class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  # Um usuário pode seguir muitos outros usuários
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  # Um usuário pode ser seguido por muitos outros usuários
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  #   enum role: { admin: 0, user: 1 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def following?(other_user)
    following.include?(other_user)
  end
end
