Rails.application.routes.draw do
  
  devise_for :users
  root  'static_pages#home'
  
  get 'cart/index'

  resources :items
 

  get '/help' => 'static_pages#help'

  get '/about' => 'static_pages#about'
  
  get '/cart/:id', to: 'cart#add' 
  get '/cart', to: 'cart#index'
  get '/clearcart', to: 'cart#clearCart'
  
  get '/cart/remove/:id' => 'cart#remove'
  get '/cart/decrease/:id' => 'cart#decrease'
  
  
  get '/login' => 'user#login' 
  get '/logout' => 'user#logout'
  
  root :to => 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
