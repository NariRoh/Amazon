require 'rails_helper'

# Test drive the destroy, show and index actions for your Amazon applications.
# Assume that they are standard as done in class. Do as you did in the previous
# lab (i.e. comment out all the code inside the ProductsController class to
# guarantee that the tests fail initially)
#
# [Stretch]: Refactor your controller as follows:
#
# Have a find_product before_action to find the question for the edit / show
# / update / destroy actions
# Refactor product_params into a method


RSpec.describe ProductsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns Products instance variable and returns a list of the database content' do
      product_1 = FactoryGirl.create(:product)
      product_2 = FactoryGirl.create(:product)

      get :index
      expect(assigns(:products)).to match_array([product_2, product_1])
      # expect(assigns(:products)).to eq(Product.order(created_at: :desc))
    end
  end

  describe '#show' do
    let(:product) { FactoryGirl.create(:product) }

    it 'renders the show template' do
      # get :show, id: test_product.id
      # NEW!!
      # Deprecated style:
      # get :show, { id: 1 }, nil, { notice: "This is a flash message" }
      # New keyword style:
      # get :show, params: { id: 1 }, flash: { notice: "This is a flash message" },
      # session: nil # Can safely be omitted.
      get :show, params: { id: product.id }

      expect(response).to render_template(:show)
    end
  #
    it 'assigns the requested product to @product' do
      get :show, params: { id: product.id }
      # expect(assigns(:product)).to eq(Product.find product.id)
      expect(assigns(:product)).to eq(product)
    end

  end

  describe '#destroy' do
    let(:product) { FactoryGirl.create(:product) }

    # context 'with no signed in user' do
    context 'with owner of campaign signed in' do
      before { request.session[:user_id] = user.id }

      it 'assigns the requested product to @product' do
        delete :destroy, params: { id: product.id }
        # expect(assigns(:product)).to eq(Product.find product.id)
        expect(assigns(:product)).to eq(product)

      end

      it 'removes the record from the database' do
        expect { delete :destroy, params: { id: product.id } }.to change {Product.count}.by(-1)
        # delete :destroy, params: { id: product.id }
        # expect(Product.exists?(id: product.id)).to be(false)
        # expect{product.reload}.to raise_error(ActiveRecord::RecordNotFound)
      end

        #   it 'redirect to index page' do
        #     delete :destroy, params: { id: product }
        #     expect(response).to redirect_to(products_path)
        #   end
        # end
    end

  end

  # describe '#new' do
  #
  #   context 'with no signed in user' do
  #     it 'redirects to the sign in page' do
  #       get :new
  #       expect(response).to redirect_to(new_session_path)
  #     end
  #   end

    # context 'with signed in user' do
    #
    #   before do
    #     user = FactoryGirl.create(:user)
    #     request.session[:user_id] = user.id
    #     get :new
    #   end
    #
    # it 'renders the new template' do
    #   expect(response).to render_template(:new)
    # end
    #
    # it 'assigns a Product instance variable' do
    #   get :new
    #   expect(assigns(:product)).to be_a_new(Product)
    # end
    # end
  # end
  #
  # describe '#create' do
  # let(:product) { FactoryGirl.create(:product) }
  #   context 'with valid attributes' do
  #     it 'create a new product in the database' do
  #       # GIVEN
  #       count_before = Product.count
  #       # WHEN
  #       post :create, params: { product: FactoryGirl.attributes_for(:product) }
  #       count_after = Product.count
  #       # THEN
  #       expect(count_after).to eq(count_before + 1)
  #     end
  #
  #     it 'redirects to the product show page' do
  #       post :create, params: { product: FactoryGirl.attributes_for(:product) }
  #       expect(response).to redirect_to(product_path(Product.last))
  #     end
  #
  #   end
  # end

end
