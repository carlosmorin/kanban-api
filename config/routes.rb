Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :projects do
        post :members
      end
  		resources :categories
    end
  end
end
