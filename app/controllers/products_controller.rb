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
    @tags = @product.tags
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

  # Parameters: { "utf8"=>"✓",
  #"authenticity_token"=>"RFmIm/HU1VgiTCD+96KlDcxvkbRbUlf+9trvmztZpcHU3K6iZ9VtNlMrS9lMriMV+fkKZsEO7bfFI3iJ9+DJiw==",
  #   "product"=>
  #     {"title"=>"Tempor",
  #      "category_id"=>"3",
  #      "description"=>"Deserunt architecto magna et unde velit",
  #      "price"=>"6",
  #      "tag_ids"=>["", "4", "6", "7"]},
  #      "commit"=>"Create Product" }
  # Unpermitted parameter: tag_ids

  # Parameters: {"utf8"=>"✓",
  # "authenticity_token"=>"+5xyH3Y9r/nslydBJo8bclI4Eyxh2Swi85qOa0I8ILVrGVQm4DwXl53wTGadg51qZ66I/vuFlmvAYxl5joVM/w==",
  #   "product"=>
  #     {"title"=>"Sit ea non mollitia sint accusantium",
  #      "category_id"=>"5",
  #      "description"=>"Officia esse beatae non adipisicing", "price"=>"611",
  #      "tag_ids"=>["", "5", "6", "8", "9"]},
  #      "commit"=>"Create Product" }

  def product_params
    product_params = params.require(:product).permit([:title,
                                                      :description,
                                                      :price,
                                                      :category_id,
                                                      { tag_ids: [] }
                                                      ])
  end

  def authorize
    if cannot?(:manage, @product)
      redirect_to root_path, alert: 'Not authorized!'
    end
  end

end
