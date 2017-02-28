class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :reviews, lambda { order(created_at: :desc) }, dependent: :destroy

  # after_initialize :set_defaults_price
  # before_save :titleize_title
  before_create :set_sale_price

  validates :title, presence: true, uniqueness: true
  # # validates :title, :price, presence: true
  # # validates_presence_of :title, :price
  # # validates_uniqueness_of :title #, :price
  validates :price, numericality: { greater_than: 0 }
  # validates :description, presence: true, length: { minimum: 10 }
  validates :sale_price, numericality: { less_than_or_equal_to: :price }, if: :sale_price

  # validate :reserved_words

  def self.search(query)
    where("title ILIKE ?", "%#{query}%") |
    where("description ILIKE ?", "%#{query}%")
  end

  def self.filtering(search_term, sort_by_column, current_page, per_page_count)
    current_page = current_page.to_i - 1
    per_page_count = per_page_count.to_i
    offset = current_page * per_page_count

    where('title ILIKE ? or description ILIKE ?', "%#{search_term}%", "%#{search_term}%").order("#{sort_by_column} DESC").limit(per_page_count).offset(offset)
  end
  #
  # def increment_hit_count(by = 1)
  #   self.hit_count ||= 0
  #   self.hit_count += by
  #   self.save
  # end



  private


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

  def titleize_title
    self.title = title.titleize if title.present?
  end

  def on_sale?
    self.sale_price < self.price
  end
end
















#
