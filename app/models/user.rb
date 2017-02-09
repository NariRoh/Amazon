class User < ApplicationRecord
  validates :first_name, presence: true

  def self.search(query)
    where("first_name ILIKE ? or last_name ILIKE ? or email ILIKE ?", "#{query}", "#{query}", "#{query}")
  end

  private



end
