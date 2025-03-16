class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  #   enum role: { admin: 0, user: 1 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
