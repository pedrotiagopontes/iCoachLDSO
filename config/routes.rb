Icoach::Application.routes.draw do
  devise_for :users

  resources :tokens,:only => [:create, :destroy]

  resources :clubs do
    resources :teams do
      resources :players
      resources :injuries
      resources :practices do
        resources :presences
      end
      resources :games do
        resources :events
      end
    end
  end



  match '/clubs/:club_id/teams/:team_id/games/:game_id/end' => 'games#end', :as => 'end_club_team_game', :via => :put
  match '/clubs/:club_id/teams/:team_id/practices/:practice_id/presences' => 'practices#presences', :as => 'presences_club_team_practice', :via => :get
  match '/clubs/:club_id/teams/:team_id/injuries/:id/healed' => 'injuries#healed', :as => 'club_team_injury_healed', :via => :get
  root :to => 'clubs#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
