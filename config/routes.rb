Rails.application.routes.draw do  
  scope '/api' do
    scope 'v1' do    
      
      post '/auth', to: 'sessions#api_auth'
      
      resources :tags do
        resources :places
      end
      
      resources :creators do
        resources :places
      end
      
      resources :places do
        resources :tags
      end
    end
  end
end
