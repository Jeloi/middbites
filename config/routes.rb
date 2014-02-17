Middbites::Application.routes.draw do
  
 

  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'pages#home'

  get "pages/home"
  get "pages/about"
  get "menus(/:date)", to: 'pages#menus', as: 'menus'

  # Recipe routes
  get 'recipes/create' => 'recipes#new', as: 'new_recipe'
  get 'recipes/popular' => 'recipes#popular', as: 'popular_recipes'
  get 'recipes/recent' => 'recipes#recent', as: 'recent_recipes'
  get 'recipes/top' => 'recipes#top', as: 'top_recipes'

  resources :recipes, except: :new 
  delete 'recipes/:id' => 'recipes#destroy', as: 'destroy_recipe'
  delete 'recipes/:id/unvote' => 'recipes#unvote', as: 'unvote_recipe'
  post 'recipes/:id/vote' => 'recipes#vote', as: 'vote_recipe'



  # Search Routes
  get "search", to: 'search#search', as: 'search'

  # Comment Routes
  resources :comments, only: [:create, :destroy]
  get 'load_comments/:id' => 'comments#load_comments', as: 'load_comments'

  # Item routes
  get "ingredients" => 'items#categorized', as: "categorized_items"
  get "ingredients/alphabetical" => 'items#alphabetical', as: "alphabetical_items"
  get "ingredients/popular" => 'items#popular', as: 'popular_items'
  get "ingredients/:id" => 'items#show', as: 'item'

  # Tags routes
  # get 'tags/:tag', to: 'recipes#all', as: :tag
  get "tags/all" => 'tags#all', as: 'all_tags'
  get "tags", to: 'tags#grouped', as: 'grouped_tags'
  get "tags/:id" => 'tags#show', as: 'tag'


  # Omniauth routes
  # get 'auth/:provider/callback', to: 'sessions#create'
  # get 'auth/failure', to: redirect('/')
  # get 'signout', to: 'sessions#destroy', as: 'signout'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
