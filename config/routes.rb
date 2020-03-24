Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'home/index'

  resource :calendar do
    member do
      get 'simple_events'
      get 'recurring_events'
      get 'user_simple_events'
      get 'user_recurring_events'
    end
  end

  resources :recurring_events
  resources :simple_events
end
