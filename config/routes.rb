Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login_staff', to: 'sessions#new_staff'
  post 'login_staff', to: 'sessions#create_staff'	
  delete 'logout_staff', to: 'sessions#destroy_staff'
  
  get 'login', to: 'sessions#new_customer'
  post 'login', to: 'sessions#create_customer'	
  delete 'logout', to: 'sessions#destroy_customer'
  
  get 'shop_list', to: 'shops#index'
  get 'shop_product/:id', to: 'shops#show', as: 'shop_product'
  
  put 'stock', to: 'products#stock', as: 'stock'
  
  get 'staff_signup', to: 'staffs#new'
  resources :staffs, only: [:index, :create, :edit, :update, :destroy]
  
  get 'review/:id', to: 'reviews#show', as: 'review'
  
  resources :products do
    resource :favorites, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
    collection do
      post 'import'
    end
  end
  
  resources :customers do
    member do
      get 'orders'
      get 'order_details'
      get 'favorites'
      get 'reviews'
    end
  end
  
  post   'cart_in', to: 'carts#create'
  put    'cart_edit', to: 'carts#update'
  delete 'cart_out', to: 'carts#destroy'
  
  resources :carts, only: [:show] do
    collection do
      delete 'destroy_all'
    end
  end
  
  resources :orders, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post 'confirm'
    end
    
    member do
      get 'thanks'
    end
    
    collection do
      get 'export'
      get 'search'
    end
  end
end
