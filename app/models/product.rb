class Product < ApplicationRecord
  after_initialize :set_defaults_price
  before_save :capitalize_title
  before_create :set_sale_price


  validates :title, presence: true, uniqueness: true
  # validates :title, :price, presence: true
  # validates_presence_of :title, :price
  # validates_uniqueness_of :title #, :price
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :sale_price, numericality: { greater_than_or_equal_to: :price }, if: :sale_price
  validate :reserved_words


  private


  def self.search(query)
    where("title ILIKE ?", "%#{query}%") |
    where("description ILIKE ?", "%#{query}%")
  end

  def reserved_words
    reserved = ['apple', 'microsoft', 'sony']
    reserved.each do |word|
      if title.present? && title.downcase.include?(word)
        errors.add(:title, "can't be used with '#{title}'")
      end
    end
  end

  def set_sale_price
    self.sale_price ||= self.price
  end

  def set_defaults_price
    self.price ||= 1
  end

  def capitalize_title
    self.title.titleize
  end
end

# Given a product model with name and price:
#
# Write a validation that makes sure that the name is present, unique and that it's not any of these reserved words: Apple, Microsoft & Sony.
# Note: Use the Amazon app.
