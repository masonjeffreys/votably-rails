Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  get '/public/:id',   to: 'public_views#show', as: "public"
  get '/respond/:id', to: 'poll_responses#new', as: "respond"

  resources :polls do
  	resources :poll_choices, only: [:new, :create]
  	resources :poll_responses, only: [:create]
    get :test, :on => :member
  end

  root 'polls#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
