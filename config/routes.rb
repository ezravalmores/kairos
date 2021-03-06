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
  #match "/profile" => "profile#time", :as => :time
  #match "/user_liv" => "user_liv#create_leave", :as => :create_leave, :via => [:post]
  match "/approvals/tasks_approval" => "approvals#tasks_approval", :as => :tasks_approval
  match "/approvals/leaves_approval" => "approvals#leaves_approval", :as => :leaves_approval
  match "/approvals/canceled_leaves_approval" => "approvals#canceled_leaves_approval", :as => :canceled_leaves_approval
  
  match "/reports" => "reports#child_sponsorships_graph", :as => :child_sponsorships_graph  
  match "/reports/tasks_report" => "reports#tasks_report", :as => :tasks_report
  match "/reports/utilization_rate_report" => "reports#utilization_rate_report", :as => :utilization_rate_report  
  match "/reports/search_tasks" => "reports#search_tasks", :as => :search_tasks
  #match "/people" => "people#welcome_message", :as => :welcome_message
  match "/reports/generate_spreadsheets" => "reports#generate_spreadsheets", :as => :generate_spreadsheets
  match 'profile/update_specific_activity_select/:id', :controller=>'profile', :action => 'update_specific_activity_select'
  match "user_livs/:id/cancel_leave", :to => "user_livs#cancel_leave",:as => :cancel_leave ,:via => [:get]
  match "dynamic_specific_tasks/:id" => "person_times#dynamic_specific_tasks", :via => [:post]
  match "reports/search_task_id/:id" => "reports#search_task_id", :via => [:post]
  match "activities/:id/deactivate", :to => 'activities#deactivate', :as => :deactivate_activity ,:via => [:get]
  match "specific_activities/:id/deactivate", :to => 'specific_activities#deactivate', :as => :deactivate_specific_activity ,:via => [:get]
  
  match "activities/:id/activate", :to => 'activities#activate', :as => :activate_activity ,:via => [:get]
  match "specific_activities/:id/activate", :to => 'specific_activities#activate', :as => :activate_specific_activity ,:via => [:get]
  
  match "reports/update_from_remote", :to => 'person_times#update_from_remote', :as => :update_from_remote ,:via => [:get]
  
  
  #resources :approvals do
  #  collection do
  #    put :approve_leaves
  #  end    
  #end  
  resources :ncmm_activities do
    collection do
      post :create_activity
    end
  end    
  
  resources :user_livs do
    collection do
      post :create_leave
      put :submit_leaves
      put :approve_leaves
      put :approve_canceled_leaves
    end    
  end
  
    resources :people, :except => [:show] do
      member do
        put :welcome_message
      end
    end
  resources :activities
  resources :calendars
  resources :specific_activities
  resources :person_times do
    collection do
      put :update_activity
      put :submit_activities
      put :approve_activities
    end
    
   # member do
   #    put :update_from_remote
   #  end  
  end
  #resources :reports #do
  #collection  do  
  #   get :child_sponsorships_graph
  #end   
  #end    
  #resources :total_hours
  
  match "person_times/:id/update_is_overtime", :to => "person_times#update_is_overtime", :as => :update_is_overtime, :via => [:get]
  match "person_times/:id/update_is_not_overtime", :to => "person_times#update_is_not_overtime", :as => :update_is_not_overtime, :via => [:get]      
end
