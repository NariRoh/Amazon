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
    product = Product.new product_params
    product.user = @user

    if product.save
      render json: { success: true, id: product.id }
    else
      render json: { success: false, errors: product.errors.full_messages }
    end

  end

  def update
    product = Product.find params[:id]

    if product.update product_params
      render json: { success: true, id: product.id }
    else
      render json: { success: false, errors: product.errors.full_messages }
    end
  end

  def destroy
    product = Product.find params[:id]

    if product.destroy
      render json: { success: true }
    else
      render json: { success: false, errors: product.errors.full_messages }
    end
  end

  private

  def product_params
    product_params = params.require(:product).permit(:title,
                                                     :description,
                                                     :price,
                                                     :sale_price,
                                                     :category_id,
                                                     :user_id)
  end
end
