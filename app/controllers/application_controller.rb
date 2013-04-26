class ApplicationController < ActionController::Base
  protect_from_forgery
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from ActiveRecord::RecordNotFound, :with => :redirect_to_application_url
  end
  
  # Setup any global page variables (CSS, JavaScript, etc.)
  #before_filter :stylize
  
  def index
    
     if current_user
       
        person_times_url
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
      
      def clear_sessions
        session[:from_date] = nil
        session[:to_date] = nil
        session[:department_id] = nil
        session[:person_id] = nil
        session[:activity_id] = nil
        session[:what_report] = nil
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
          unless !current_user.is_supervisor? || !current_user.is_admin? 
            redirect_to :back
            flash[:warning] = "You are not authorize!"
          end
       end
       
    def current_user
      @current_user ||= fetch_user
    end
    helper_method :current_user
    def notifications
      @notifications = Notification.unread_notifications(current_user) + Notification.read_notifications(current_user)
    end  
    helper_method :notifications
     
    def fetch_user
      Person.find(session[:user_id]) unless session[:user_id].nil?
    end
end
