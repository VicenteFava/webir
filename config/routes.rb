Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :deals do
	  collection do 
	  	get 'filter'
	  	get 'index'
	  	get 'show'
	  end 
  end
  # get 'index', to: 'deals#index'

end
  