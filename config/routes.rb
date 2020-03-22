Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'

  resource :calendar do
    member do
      get 'simple_events'
      get 'recurring_events'
      get 'my_simple_events'
      get 'my_recurring_events'
    end
  end

  resources :recurring_events
  resources :simple_events
end
