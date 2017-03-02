class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]

  def new
    # render nothing: true
    @product = Product.new
  end

  def create
    # render json: params[:product]
    @product = Product.new(product_params)

    @product.user = current_user
   if @product.save
      redirect_to product_path(@product)
      # render plain: 'success'
    else
      render :new
      # logger.error "Product failed Validations: \n - #{joined_errors}"
      logger.error @product.joined_errors
    end
  end

  def show
    @product.increment_hit_count
    @review = Review.new
  end

  def index
    @products = Product.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product)
      # render plain: 'success'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    product_params = params.require(:product).permit(:title, :description, :price, :category_id)
  end

  def authorize
    if cannot?(:manage, @product)
      redirect_to root_path, alert: 'Not authorized!'
    end
  end

end
