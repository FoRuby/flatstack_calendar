Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/index'

  resource :calendar, only: :show

  resources :recurring_events, only: %i[show create update destroy] do
    get 'public', on: :collection
  end

  resources :simple_events, only: %i[show create update destroy] do
    get 'public', on: :collection
  end

  namespace :user_events do
    get 'simple'
    get 'recurring'
  end
end
