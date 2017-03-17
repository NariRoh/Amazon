class ReviewsMailer < ApplicationMailer
  def notify_product_owner(review)
    @review  = review
    @product = @review.product
    @owner   = @product.user
    mail(to: @owner.email, subject: "You got a new review!")
  end
end
