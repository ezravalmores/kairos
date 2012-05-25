require 'time_diff'

class PersonTimesController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_filter :authorize
  
  def new
    @person_time = PersonTime.new
    respond_to do |format|
      format.js {}
    end  
  end
  
  def edit
    @person_time = PersonTime.find(params[:id])
    @activities = Activity.all
     respond_to do |format|
       format.html {}
     end
  end  
  
  def create
    @person_time = PersonTime.new(params[:person_time])
    @activities = current_user.person_times
    respond_to do |format|
      if @person_time.save
        format.html { redirect_to :back }
        format.js {} # create.js.erb
      else
        format.html { render action: "new" }
        format.js {
        render :nothing => true
        }
      end
    end
  end  
  
  def update
    @person_time = PersonTime.find(params[:id])
    @person_time.update_attributes(params[:person_time])  
    respond_to do |format| 
      format.html { redirect_to tasks_report_url }
    end
    flash[:notice] = "Your activity was successfully updated!"  
  end  
  
  def update_activity
    unless params[:person_time_id].nil? || params[:activity_id].nil? 
      @activity = Activity.find(params[:activity_id])
      
      person_time = PersonTime.find(params[:person_time_id])
      
      updated = person_time.update_attributes(:activity_id => @activity.id,:specific_activity_id => params[:specific_activity_id],:end_time => Time.now.to_s(:db))
      
      person_time.reload
      
      difference = Time.diff(Time.parse(person_time.start_time.strftime('%H:%M:%S')), Time.parse(person_time.end_time.strftime('%H:%M:%S')), '%h:%m:%s')
      total_time = difference[:hour].to_s + ":" + difference[:minute].to_s + ":" + difference[:second].to_s
      
      updated = person_time.update_attributes(:total_time => total_time)
      
      if params[:end_shift].to_i != 1
        new_activity = PersonTime.create!(:person_id => current_user.id,:start_time => person_time.end_time) 
      else
        @person = current_user
        @activities = @person.person_times.user_activities_today.order("created_at DESC") 
        @productive_hours = @activities.get_productive_hours
        hours = PersonTime.calculate_total_hours(@productive_hours.map {|a| a.id},"hours")
        minutes = PersonTime.calculate_total_hours(@productive_hours.map {|a| a.id},"minutes")
        th = number_with_precision(TotalHour.save_utilization_rate(hours,minutes),:precision => 2)
        TotalHour.create!(:person_id => current_user.id,:total_utilization_rate => th, :shift_date => Date.today)
      end
       
      respond_to do |format|
        format.html { redirect_to time_url  }
      end
      
      flash[:notice] = "Your activity was successfully ended!"  
    else
      
    end    
  end
  
  def submit_activities
    if !params[:people].nil? 
      activities = params[:activities]
      people = Person.find(params[:people])
      #people = people.map {|p| p.email_address}
      PersonTime.submit_activities(current_user.id,activities)
      for person in people
        Kairos1Mailer.send_approvals(person,current_user).deliver
      end
      flash[:notice] = "Your activies submitted successfully!"
    else
      flash[:warning] = "Select People who will be notified with this submission"  
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
    end  
  end
  
  def approve_activities
    if params[:activities].nil?
      redirect_to :back
      flash[:warning] = "No Items were selected, please select in the list."
    else      
      activities = params[:activities]
      PersonTime.approve_activities(current_user.id,activities)
      redirect_to(approval_url)
      flash[:notice] = "Approvals Successfully made!"
    end
  end
  
  # PUT /people/1/update_is_overtime
   def update_is_overtime
     person_time = PersonTime.find(params[:id])
     if person_time.start_time >= current_user.end_time  
     respond_to do |format|
       if person_time.update_attributes(:is_overtime => true,:updated_by => current_user.id)
         flash[:notice] = "Your activity from #{person_time.start_time.strftime("%H:%M:%S")} to #{person_time.end_time.strftime("%H:%M:%S")} was successfullt marked as overtime.   "   
       else
         flash[:warning] = "Couldn't update activity..."
       end
       format.html { redirect_to(time_url) }
     end
     else
       flash[:warning] = "Couldn't update to overtime because your time settings covered this activity"
       redirect_to :back
     end   
   end
   
   # PUT /people/1/update_is_overtime
    def update_is_not_overtime
      person_time = PersonTime.find(params[:id])
      respond_to do |format|
        if person_time.update_attributes(:is_overtime => false,:updated_by => current_user.id)
          flash[:notice] = "Your activity from #{person_time.start_time.strftime("%B %d, %Y")} to #{person_time.end_time.strftime("%B %d, %Y")} was successfullt marked as standard.   "   
        else
          flash[:warning] = "Couldn't update activity..."
        end
        format.html { redirect_to(time_url) }
      end
    end
    
    def destroy
      @person_time = PersonTime.find(params[:id])
      @person_time.destroy

      flash[:notice] = 'The tasks has been successfuly deleted'
      redirect_to :back
    end      
end
