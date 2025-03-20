class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many_attached :images
  validate :validate_image_count
  validates :content, presence: true, length: { maximum: 255 }

  private
  def validate_image_count
   if images.length > 10
     errors.add(:images, "Você pode adicionar no máximo 10 imagens.")
   end
  end
end
