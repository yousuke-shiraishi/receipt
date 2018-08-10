Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
  registrations: "users/registrations",
  omniauth_callbacks: "users/omniauth_callbacks"
}
  root :to => 'oauth_test#index'
  get 'favorites/create'
  get 'favorites/destroy'
  resources :contacts
  resources :users
  resources :favorites, only: %i[create destroy]
  # resources :pictures
  resources :pictures do
    collection do
      get :confirm
      post :check
      match 'search' => 'pictures#search', via: [:get, :post], as: :search
    end
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
