class LoginController < ApplicationController
  def login
    session[:user_id] = nil
    if request.post?
      @user = Person.authenticate(params[:username],params[:password])
      if @user
        if Time.now.strftime('%H:%M:%S') >= @user.start_time.strftime('%H:%M:%S')
          session[:user_id] = @user.id
          activities_today = @user.person_times.user_activities_today
          s = DateTime.current
          session[:start] = PersonTime.create!(:person_id => current_user.id, :start_time => s, :created_at => s, :updated_at => s) if activities_today.length == 0
          redirect_to person_times_url
        else
          reset_session
          redirect_to :action => :login
          flash[:warning] = "Sorry, you can't login at the moment, wait for your shift to start"
        end  
      else
        flash[:warning] = "Username or Password incorrect!"
      end
    end
  end
  
  def logout
      reset_session
      redirect_to :action => :login
  end
end
