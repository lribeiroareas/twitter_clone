Rails.application.routes.draw do
  devise_for :users
	root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :tweets
 resources :users, only: [:index, :show]
 resources :relationships, only: [:create, :destroy]
 
end
