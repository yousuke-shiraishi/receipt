Rails.application.routes.draw do

  root to: 'pictures#index'
  get 'favorites/create'
  get 'favorites/destroy'
  get 'sessions/new'
  resources :contacts
  resources :sessions, only: %i[new create destroy]
  resources :users
  resources :favorites, only: %i[create destroy]
  # resources :pictures
  resources :pictures do
    collection do
      get :confirm
      post :check
    end
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
