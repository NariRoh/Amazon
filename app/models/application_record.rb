class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def joined_errors
    "#{self.class.to_s} failed Validations:\n"
    "#{self.errors.full_messages.join("\n - ")}"
  end
end
