Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users
      resources :categories
      resources :comments
      resources :tags

      resources :projects do
        post :members
      end

      resources :issues do
        patch :update_status
        post :tags
      end

    end
  end
end
