class ProfileController < ApplicationController
  before_filter :authorize, :clear_sessions
  
  # GET /profile
  def index
    @person = current_user
      session[:leaves] = 'none'
      session[:time] = 'active'
      session[:calendar] = 'none'
      session[:approvals] = 'none'
      session[:reports] = 'none'
      session[:admin] = 'none'
     
     if !params[:date].nil?
       @activities = @person.person_times.search_by_date(params[:date].to_time).order('created_at DESC')
     else
       @activities = @person.person_times.user_activities_today.order("created_at DESC") 
     end
     unfinished_activity = @activities.search_user_activity_not_yet_ended_today(current_user.id)
     @unfinished_activity = PersonTime.find(unfinished_activity.map {|u| u.id }).last
     @activities_set = Activity.all
     @breaks = @activities.get_breaks(Activity.find_by_name("Break").id)
     @productive_hours = @activities.get_productive_hours
     @other_people_activities = PersonTime.user_activities_today.other_user_activities_today(current_user.id)   
     @persons_can_approved = Person.persons_can_approve(current_user.department_id) + Person.get_admins
     
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @activities }
     end
  end  
  
  def dynamic_specific_tasks
      @specific_tasks = SpecificActivity.find_all_by_activity_id(params[:id])

      respond_to do |format|
        format.js{}           
      end
  end
  
  def update_activity
     unless params[:activity_id] == 'Select Activity'
       @activity = Activity.find(params[:activity_id])

       person_time = PersonTime.find(params[:person_time_id])

       updated = person_time.update_attributes(:activity_id => @activity.id,:specific_activity_id => params[:specific_activity_id],:end_time => Time.now.to_s(:db))

       person_time.reload

       difference = Time.diff(Time.parse(person_time.start_time.strftime('%H:%M:%S')), Time.parse(person_time.end_time.strftime('%H:%M:%S')), '%h:%m:%s')
       total_time = difference[:hour].to_s + ":" + difference[:minute].to_s + ":" + difference[:second].to_s

       updated = person_time.update_attributes(:total_time => total_time)

       if params[:end_shift].to_i != 1
         new_activity = PersonTime.create!(:person_id => current_user.id,:start_time => person_time.end_time) 
       end
       respond_to do |format|
         flash[:notice] = "Your activity was successfully ended!"  
         format.js { render :file => 'update_activity.js' }     
       end

     else
       flash[:warning] = "Sorry, you need to select task to end it."  
     end   
   end
   
   def show

   end
end
