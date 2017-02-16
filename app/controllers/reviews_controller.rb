class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, only: [:destroy]
  before_action :authorize, only: [:destroy]


  def create
    review_params = params.require(:review).permit(:rating, :body)
    @review = Review.new review_params
    @product = Product.find params[:product_id]
    @review.product = @product
    @review.user = current_user

    if @review.save
      redirect_to product_path(params[:product_id]), notice: 'Review Created!'
    else
      flash[:alert] = 'Please fix your errors'
      render 'products/show'
    end
  end

  def destroy
    # @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(@review.product_id), notice: 'Review deleted!'
  end

  private

  def find_review
    @review = Review.find params[:id]
  end

  def authorize
    if cannot?(:manage, @review)
      redirect_to 'products/show', alert: 'Not authorized!'
      # render plain: 'noooo'
    end
  end

end
