require 'rails_helper'

# title and price must be present
# title is unique
# sale_price is set to price by default if not present
# sale_price must be less than or equal to price
# a method called on_sale? that returns true or false whether the product is on sale or not

# this:
# let(:foo) { Foo.new }
# is very nearly equivalent to this:
# def foo
#   @foo ||= Foo.new
# end

RSpec.describe Product, type: :model do

  let(:product) { FactoryGirl.create(:product) }

  describe 'validations' do
    it 'requires a title' do
      # p = Product.new FactoryGirl.attributes_for(:product, title: nil) // attributes_for returns a hash
      p = FactoryGirl.build(:product, title: nil)

      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it 'requires price' do
      p = FactoryGirl.build(:product, price: nil)
      p.valid?
      expect(p.errors).to have_key(:price)
    end

    it 'requires a unique title' do
      # Product.create(title: 'new product')
      # p = FactoryGirl.create(:product)
      product
      p1 = FactoryGirl.build(:product, title: product.title)
      p1.valid?
      expect(p1.errors).to have_key(:title)
    end

    it 'requires the sale price is set to price by default if not present' do
      # p = Product.create title: 'new product', price: 30
      # p = FactoryGirl.create(:product)
      product
      expect(product.sale_price).to eq(product.price)
    end

    it 'requires a sale_price to be less than or equal to price' do
      # p = Product.new title: 'new product', price: 30, sale_price: 40
      p = FactoryGirl.build(:product, price: 30, sale_price: 40)
      p.valid?
      expect(p.errors).to have_key(:sale_price)
    end

    it 'requires on_sale? method to return true or false' do
      # p = Product.create title: 'new product', price: 30, sale_price: 30
      p = FactoryGirl.create(:product)
      expect(p.on_sale?).to be(false)
    end

  end
end
