class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :rating, presence: true, numericality: { less_than: 6, greater_than: 0 }

  def like_for(user)
    likes.find_by(user: user)
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end
end
