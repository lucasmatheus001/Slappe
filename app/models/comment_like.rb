class CommentLike < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: { scope: :comment_id, message: "já curtiu este comentário" }
end
