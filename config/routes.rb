Rails.application.routes.draw do
  root 'calendars#calendar'

  resource :calendar do
    member do
      get 'simple_events'
      get 'recurring_events'
      get 'my_simple_events'
      get 'my_recurring_events'
      get 'calendar'
    end
  end

  resources :recurring_events
  resources :simple_events
end
