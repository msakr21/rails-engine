Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/vi/merchants/find', to: 'api/v1/merchants#find'

  get '/api/vi/items/find_all', to: 'api/v1/items#find_all'

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        match 'find', :on => :collection, :via => [:get, :post]
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
