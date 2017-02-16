class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :rating, presence: true, numericality: { less_than: 6, greater_than: 0 }
end
