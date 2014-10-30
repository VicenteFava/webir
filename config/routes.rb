Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :deals, only: [:index, :show]

  # get 'index', to: 'deals#index'

end
  