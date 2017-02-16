class Admin::PanelController < Admin::BaseController

  def index
    @product_count = Product.count
    @review_count = Review.count
    @user_count = User.count

    @products = Product.all
    @users = User.all
  end
end
