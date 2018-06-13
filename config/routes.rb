Rails.application.routes.draw do
  root 'exports#index'
  resources :exports do
    collection do
      get :trigger
    end
  end

  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
