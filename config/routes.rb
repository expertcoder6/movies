Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'authentication#signup'
      post 'signin', to: 'authentication#signin'

      resources :films, only: [:index, :create, :update, :show]

      post 'getdata', to: 'films#getdata'
    end
  end
end
