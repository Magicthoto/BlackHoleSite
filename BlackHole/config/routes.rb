Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :admins
  resources :users
  resources :messages
  resources :sessions, :only => [:new, :create, :destroy]
  resources :videos, :only => [:index, :create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  root 'home#index'

  get 'home/signIn',  :to => 'sessions#new', :path => "SignIn"
  get 'home/signOut', :to => 'sessions#destroy', :path => "SignOut"

  get 'users/new', :to => 'users#new', :path => "CreateYourAccount"

  get 'users/destroy', :to => 'users#destroy', :path => "EraseMyAccount"

  get 'users/:id', :to => 'users#show'
  get 'users/edit', :to => 'users#edit', :path => "Edit My Profil"
  get 'users/show', :to => 'users#show', :path => "Show My Profil"
  get 'users/index', :path => "Index"

  get 'home/help', :path => "Help"
  get 'home/conditions', :path => "Conditions_of_use"
  get 'home/legals', :path => "Legals"
  get 'home/contact', :to => "messages#new", :path => "ContactUs"
  get 'home/team', :path => "Team"
  get 'home/about', :path => "About"

  get 'videos/index', :to => "videos#index", :path => "Media"
  get 'videos/create', :to => "videos#create"
  get 'videos/new', :to => "videos#new", :path => "UploadYourVideo"
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
