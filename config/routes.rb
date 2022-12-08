Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :items
    end
  end

  get '/api/v1/items/:id/merchant', to: 'api/v1/item_merchants#show', as: :item_merchants
end
