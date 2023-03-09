Rails.application.routes.draw do
  get 'password_resets/new' => 'password_resets#new'

  get 'password_resets/edit' => 'password_resets#edit'

#  get 'password_resets/<token>/edit' 

  get 'revs/export' => 'revs#export'


  get 'static_pages/news'
  root 'static_pages#news'
  get 'static_pages/Cube'
  get 'static_pages/WhatsApp'

  get 'static_pages/pauper'

  get 'static_pages/PDH'

  get 'static_pages/links'


	get 'comments/new' => 'comments#new'
  	get 'users/new' => 'users#new'
	get 'decks/new' => 'decks#new'
	get 'sessions/new' => 'sessions#new'
	get 'revs/new' => 'revs#new'
	get 'revs/compare' => 'revs#compare'

	resources :decks do
		resources :revs
	end

	resources :decks do
		resources :revs do
			get :setPhysical
			get :unsetPhysical
			get :export
		end
	end

	resources :comments
	resources :decks
	resources :users
	resources :password_resets,	only: [ :new, :create, :edit, :update]
	resources :cards
	resources :revs

	#get 'decks/show'
	get 'login' => 'sessions#new'
	post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
	delete 'logout' => 'sessions#destroy'
#	get '/decks/:id/:rev' 

#edit_deck_rev GET    /decks/:deck_id/revs/:id/edit(.:format) revs#edit

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
