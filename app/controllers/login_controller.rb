class LoginController < ApplicationController
  def login
    session[:user_id] = nil
    if request.post?
      @user = Person.authenticate(params[:username],params[:password])
      if @user
        session[:user_id] = @user.id
        activities_today = @user.person_times.user_activities_today
        session[:start] = PersonTime.create!(:person_id => current_user.id, :start_time => Time.now.to_s(:db), :created_at => Time.now, :updated_at => Time.now) if activities_today.length == 0
        redirect_to time_url
      else
        flash[:notice] = "Could not log you in!"
      end
    end
  end
  
  def logout
      reset_session
      redirect_to :action => :login
  end
  

end
