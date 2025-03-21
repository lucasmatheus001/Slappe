class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id, message: "já curtiu este post" }
end
