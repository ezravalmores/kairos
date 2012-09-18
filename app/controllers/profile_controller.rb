class ProfileController < ApplicationController
  before_filter :authorize
  
  # GET /profile
  def time
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
  end  
  
  def dynamic_specific_tasks
      @specific_tasks = SpecificActivity.find_all_by_activity_id(params[:id])

      respond_to do |format|
        format.js{}           
      end
  end
end
