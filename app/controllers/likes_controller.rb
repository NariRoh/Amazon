class LikesController < ApplicationController
  # before_action :authorize, only: [:create]

  def create
    @review = Review.find params[:review_id]

    like = Like.new user: current_user, review: @review

    if cannot? :like, @reveiw
      redirect_to product_path(@review.product),
      alert: 'Cannot like your own review'
      if like.save
        redirect_to product_path(@review.product), notice: 'Liked!'
      else
        redirect_to product_path(@review.product), alert: 'Something is wrong'
      end
    end
  end

  def destroy
    # render json: params

    like = Like.find params[:id]
    @review = @like.review

    if like.destroy
      redirect_to product_path(@review.product), notice: 'Un liked!'
    else
      redirect_to product_path(@review.product), alert: 'Something is wrong'
    end
  end

  private

  def authorize
  end

end
