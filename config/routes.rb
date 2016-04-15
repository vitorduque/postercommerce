Rails.application.routes.draw do
  resources :posters
  resources :clients
  resources :store
  resources :cart
  resources :admin
  resources :admin_orders

  match '/log_in' => 'login#log_in', via: [:post]
  #match '/login/logout' => 'login#log_out', via: [:get]
  resources :login
  resources :orders
  #INDEX, NEW, CREATE, EDIT, UPDATE, DESTROY
  #LOGIN_URL, LOGIN_NEW_URL, LOGIN_EDIT_URL

  root :controller => 'store', :action => 'index'

  get '/log_out', to: 'login#log_out', as: 'log_out' #log_out_path
  post 'cart/add_to_cart', to:'cart#add_to_cart', as: 'add_to_cart_path'
  get '/my_cart', to: 'store#my_cart'
  get '/empty_cart', to: 'cart#empty_cart'
  put '/clients', to: 'clients#update'
  get '/cancel_order', to: 'orders#cancel_order'

  match '/admin_log_in' => 'admin#admin_log_in', via: [:post]

  get '/admin_log_out', to: 'admin#admin_log_out', as: 'admin_logout'

  get '/set', to: 'admin_orders#set'

  #post '/edit', to: 'clients#edit'
  #post '/clients/:id/edit', to: 'clients#update'
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
