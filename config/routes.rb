Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'authentication#signup'
      post 'signin', to: 'authentication#signin'

      resources :films, only: [:index, :create, :update, :show]

      post 'getdata', to: 'films#getdata'
    end
  end
  get '/swagger/v1/swagger.yml', to: proc { [200, { 'Content-Type' => 'application/yaml' }, [File.read(Rails.root.join('swagger/v1/swagger.yml'))]] }
  
end
