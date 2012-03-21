URLShortener::Application.routes.draw do

  resources :urls, :only => [:index, :new, :create, :show] do
    member do
      get :redirect
    end
    collection do
      get :redirect
    end
  end
  
  match '/:token' => 'urls#show', :constraints => { :token => /[a-zA-Z0-9]+[+]/ }, :via => :get
  match '/:token' => 'urls#redirect', :constraints => { :token => /[a-zA-Z0-9]+/ }, :via => :get
  
  root :to => 'urls#index'
end
