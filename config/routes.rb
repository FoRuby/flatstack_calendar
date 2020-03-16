Rails.application.routes.draw do
  root 'calendar#calendar'
  resources :events
end
