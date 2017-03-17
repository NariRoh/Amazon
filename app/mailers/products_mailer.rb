class ProductsMailer < ApplicationMailer
  def notify_product_owner(product)
    @product = product
    @owner = @product.user
    mail(to: @owner.email, subject: "You created a new product!")
  end
end
