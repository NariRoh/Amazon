class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :sale_price, :created_at,
             :seller, :favourites, :tags
# Getting the details of a specific product with its comments. Make sure that product response also contains: tags, the number of likes and the name of seller, details, price, sale price, etc.
  has_many :reviews
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :rating, :body, :reviewer

    def reviewer
      object.user&.full_name
    end
  end

  has_many :tags
  class TagSerializer < ActiveModel::Serializer
    attributes :name
  end

  has_many :favourites
  # class TagSerializer < ActiveModel::Serializer
  #   attributes
  # end

  def created_at
    object.created_at.strftime('%Y-%B-%d')
  end

  def seller
    object.user&.full_name
  end

  def favourites
    object.favourites.count
  end

end
