class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, :find_product, :authorize_vote_creation, only: :create
  before_action :find_vote, :authorize_vote_change, only: [:update, :destroy]

  def create
    # review = Review.find params[:review_id]
    # product = review.product
    vote = Vote.new user: current_user, review: @review, is_up: params[:is_up]

    if vote.save
      redirect_to @product, notice: 'Voted!'
    else
      redirect_to @product, alert: vote.errors.full_messages.join(', ')
      #'Counld\'n vote'
    end
  end

  def update

    if @vote.update is_up: params[:is_up]
      redirect_to @vote.review.product, notice: 'vote changed!'
    else
      redirect_to @vote.review.product, alert: vote.errors.full_messages.join(', ')
    end

  end

  def destroy
    if @vote.destroy
      redirect_to @vote.review.product, notice: 'Vote removed'
    else
      redirect_to @vote.review.product, alert: vote.errors.full_messages.join(', ')
    end
  end

  private

  def find_vote
    @vote = Vote.find params[:id]
  end

  def find_review
    @review = Review.find params[:review_id]
  end

  def find_product
    @product = @review.product
  end

  def authorize_vote_creation
    redirect_to @product, alert: 'can\'t vote!' if cannot? :vote, @review
  end

  def authorize_vote_change
    if cannot? :manage, @vote
      redirect_to @vote.review.product, alert: 'can\'t change vote'
    end
  end

end
