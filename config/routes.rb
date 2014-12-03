Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :deals, only: [:index, :show] do
	  collection do 
	  	get 'filter'
	  	get 'index'
	  	get 'show'
	  end 
  end

  root 'deals#index'

end
  