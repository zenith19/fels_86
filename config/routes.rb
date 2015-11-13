Rails.application.routes.draw do
  root 'users#show'
  get 'signup' => 'users#new'
  get    'signin'   => 'authentications#new'
  post   'signin'   => 'authentications#create'
  delete 'signout'  => 'authentications#destroy'
  resources :authentications, only: [:new, :create, :destroy]  
  resources :categories, only: :index
  resources :users, except: :destroy
  resources :words, only: :index
  namespace :admin do
    root 'users#show'
    resources :categories, except: [:destroy, :show]
    resources :users, only: [:index, :show, :edit, :update]
    resources :words, except: :show
  end  
  resources :relationships, only: [:create, :destroy]
  #match ':controller(/:action(/:id))', :via => :get,:posts

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
