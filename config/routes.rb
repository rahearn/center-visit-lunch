Rails.application.routes.draw do
  get "lunch", to: "lunch#new"
  post "lunch", to: "lunch#create"

  root to: 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
