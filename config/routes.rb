Rails.application.routes.draw do
  # get '/' => 'home#index', as: :home
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
  root 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, except: [:edit]
    end
  end

  namespace :admin do
    resources :panel, only: [:index]
  end

  get '/about' => 'home#about'

  get '/contact' => 'home#contact'
  post '/contact_submit' => 'home#contact_submit'

  # get '/faq' => 'home#faq'

  resources :products, shallow: true do
    resources :favourites, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :votes, only: [:create, :update, :destroy]
    end
  end

  resources :users, only: [:new, :create] do
    resources :favourites, only: [:index]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :tags, only: [:index, :show]


  # www.amazon.com/sessions

  # get '/products/new' => 'products#new', as: :new_product
  # post '/products' => 'products#create', as: :products
  # get '/products/:id' => 'products#show', as: :product
  # get '/products' => 'products#index'
  # get '/products/:id/edit' => 'products#edit', as: :edit_product
  # patch '/products/:id' => 'products#update'
  # delete '/products/:id' => 'products#destroy'

  # get ''
  # resources :questions

  # get '/questions/:id' => 'questions#show'
  # get '/questions/:id/edit' => 'questions#edit'
  # delete '/questions/id' => 'questions#destroy'


  # with subfolder named controllers/admin/questions
  # same path but helper admin_question_path & admin/qustions#action
  # namespace :admin do
  #   resources :question
  # end

  # without subfolder still get path: /admin/questions...
  # but helper question_path
  # scope '/admin' do
  #   resources :questions
  # end
end
