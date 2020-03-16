Rails.application.routes.draw do
  root 'calendar#calendar'

  get 'calendar/simple_events'
  get 'calendar/recurring_events'

  resources :events
end
