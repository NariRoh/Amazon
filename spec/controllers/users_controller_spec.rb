require 'rails_helper'

# new action
#
# create action:

RSpec.describe UsersController, type: :controller do
  describe '#new' do
    # a. renders the new template
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    # b. sets an instance variable of User type
    it 'assigns a User instance variable' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe '#create' do
    # a. with valid parameters: created a user in the DB, redirects to home page
    # and signs the user in
    context 'with valid attributes' do

      def valid_request
        post :create, params: { user: FactoryGirl.attributes_for(:user)}
      end

      it 'create a new user in the database' do
        count_before = User.count
        # post :create, params: { user: FactoryGirl.attributes_for(:user)}
        valid_request
        count_after = User.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'redirects to root path' do
        # post :create, params: { user: FactoryGirl.attributes_for(:user)}
        valid_request
        expect(response).to redirect_to(root_path)
      end

    end

    context 'with invalid attributes' do
      # b. with invalid parameters: renders the new template and doesn't create
      # a user in the database
      def invalid_request
        post :create, params: { user: { email: '' } }
      end

      it 'doesn\'t create a user in the database' do
        count_before = User.count
        # post :create, params: { user: { email: '' } }
        invalid_request
        count_after = User.count
        expect(count_after).to eq(count_before)
      end

      it 'renders the new template' do
        # post :create, params: { user: { email: '' } }
        invalid_request
        expect(response).to render_template(:new)
      end

    end
  end

end
