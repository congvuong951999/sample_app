class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy 
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence:true
  validates :content, presence:true,length: {maximum:140}
  validate :picture_size

  private
    # Xac thuc kich thuoc cua 1 anh tai len.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture,"should be less than 5MB")
      end
    end
end
