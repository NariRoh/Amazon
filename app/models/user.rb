class User < ApplicationRecord
  has_secure_password

  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :nullify

  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :product

  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  before_validation :downcase_email
  # before_save :full_name

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :first_name, :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end

  def self.search(query)
    where("first_name ILIKE ? or last_name ILIKE ? or email ILIKE ?", "#{query}", "#{query}", "#{query}")
  end

  private

  def downcase_email
    self.email&.downcase!
  end

end
