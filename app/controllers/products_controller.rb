class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    # render json: params[:product]
    product_params = params.require(:product).permit(:title, :description, :price)
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product)
      # render plain: 'success'
    else
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
    @product.increment_hit_count

  end

  def index
    @products = Product.order(created_at: :desc)
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    product_params = params.require(:product).permit(:title, :description, :price)
    if @product.update product_params
      redirect_to product_path(@product)
      # render plain: 'success'
    else
      render :edit
    end
  end

  def destroy
    product = Product.find params[:id]
    product.destroy
    redirect_to products_path
  end
end
