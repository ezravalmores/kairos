class ApplicationController < ActionController::Base
  protect_from_forgery
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActiveRecord::RecordNotFound, :with => :redirect_to_application_url
  end
  
  # Setup any global page variables (CSS, JavaScript, etc.)
  #before_filter :stylize
  
  def index
     if current_user
        time_url
      else
        redirect_to login_url
      end
  end  
  
  
  protected
     def authorize
        if current_user
          application_url
        else
          redirect_to login_url
          flash[:warning] = "You are not authorize!"
        end
      end 
      
      def is_administrator
         if current_user.is_admin?
           activities_url
         else
           redirect_to :back
           flash[:warning] = "You are not authorize!"
         end
       end
       
       def is_sup_add
          if current_user.is_supervisor? || current_user.is_admin? 
            approval_url
          else
            redirect_to :back
            flash[:warning] = "You are not authorize!"
          end
        end
       
    def current_user
      @current_user ||= fetch_user
    end
     helper_method :current_user
     
    def fetch_user
      Person.find(session[:user_id]) unless session[:user_id].nil?
    end
end
