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
end
