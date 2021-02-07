Rails.application.routes.draw do
  get 'line_bot/callback'
  resources :tasks
  root "tasks#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
