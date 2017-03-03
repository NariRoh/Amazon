class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  validates :rating, presence: true, numericality: { less_than: 6, greater_than: 0 }

  def like_for(user)
    likes.find_by(user: user)
  end

  def vote_for(user)
    #votes.where(user: user).first
    votes.find_by(user: user)
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end
end
