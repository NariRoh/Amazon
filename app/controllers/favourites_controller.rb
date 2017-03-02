class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:create]
  before_action :find_favourite, only: [:destroy]

  def index
    @products = current_user.favourite_products
  end

  def create
    favourite = Favourite.new product: @product, user: current_user

    if cannot? :favourite, @product
      redirect_to product_path(@product), alert: 'Cannot favourite your own product'
    elsif favourite.save
      redirect_to product_path(@product), notice: 'Product favourited! 💖'
    else
      redirect_to product_path(@product), alert: 'Couldn\'t favourite the product! 🙁'
    end

  end

  def destroy
    if @favourite.destroy
      redirect_to product_path(@favourite.product), notice: 'Un favourited!'
    else
      redirect_to product_path(@favourite.product), alert: @favourite.errors.full_messages.join(', ')
    end
  end

  private

  def find_product
    @product = Product.find params[:product_id]
  end

  def find_favourite
    @favourite = Favourite.find params[:id]
  end

end
