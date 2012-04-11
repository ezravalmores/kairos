Ncm1Kairos::Application.routes.draw do
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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  root :to => "login#login"
  
  match "/" => "application#index", :as => :application
  match "/login" => "login#login", :as => :login
  match "/logout" => "login#logout", :as => :logout
  match "/profile" => "profile#time", :as => :time
  match "/approvals" => "approvals#approval", :as => :approval
  match "/reports" => "reports#child_sponsorships_graph", :as => :child_sponsorships_graph  
  match "/reports/tasks_report" => "reports#tasks_report", :as => :tasks_report
  match "/reports/search_tasks" => "reports#search_tasks", :as => :search_tasks
  #match "/people" => "people#welcome_message", :as => :welcome_message
  match "/reports/generate_spreadsheets" => "reports#generate_spreadsheets", :as => :generate_spreadsheets
  
  resources :leaves
    resources :people, :except => [:show] do
      member do
        put :welcome_message
      end
    end
  resources :activities
  resources :specific_activities
  resources :person_times do
    collection do
      put :update_activity
      put :submit_activities
      put :approve_activities
    end
  end
  #resources :reports #do
  #collection  do  
  #   get :child_sponsorships_graph
  #end   
  #end    
  
  match "person_times/:id/update_is_overtime", :to => "person_times#update_is_overtime", :as => :update_is_overtime, :via => [:get]
  match "person_times/:id/update_is_not_overtime", :to => "person_times#update_is_not_overtime", :as => :update_is_not_overtime, :via => [:get]      
end
