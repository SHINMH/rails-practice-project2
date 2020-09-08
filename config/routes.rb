Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
  resources :items do
    member do
      get :toggle #찜하기
    end
  end
  resources :orders
  #reoureses :users
    
  root "items#index"
end
