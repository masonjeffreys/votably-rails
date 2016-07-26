Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  get '/loaderio-301b9be9103044fa7c6d67e94b308dc7', to: 'verify#show'

  get '/public/:id',   to: 'public_views#show', as: "public"
  get '/respond/:id', to: 'poll_responses#new', as: "respond"

  resources :polls do
  	resources :poll_choices, only: [:new, :create]
  	resources :poll_responses, only: [:create]
  end

  root 'polls#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
