class Api::V1::ProductsController < Api::BaseController
  def index
    products = Product.order(created_at: :desc)
    render json: products
  end

  def show
    product    = Product.find params[:id]
    reviews    = product.reviews
    favourites = product.favourites
    tags       = product.tags

    render json: product
  end

  def create
    product_params = params.require(:product).permit(:title,
                                                     :description,
                                                     :price,
                                                     :sale_price,
                                                     :category_id,
                                                     :user_id)
  end

  def update
  end

  def destroy
  end
end
