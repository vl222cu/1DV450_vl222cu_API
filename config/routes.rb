Rails.application.routes.draw do  
  scope '/api' do
    scope 'v1' do    
      
      post '/auth'        , to: 'sessions#api_auth'
      get '/places/nearby', to: 'places#nearby'

      resources :creators do
        resources :places
      end
      
      resources :places do
        resources :tags 
      end
      
      resources :tags do
        resources :places 
      end
    end
  end
end
