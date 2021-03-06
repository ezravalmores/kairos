class ActivitiesController < ApplicationController
  before_filter :is_sup_add, :clear_sessions
  
  def index
    org = current_user.organization.departments.all
    ids = org.map {|d| d.id}
    @activities = []
    org.each do |dep|
      dep = dep.activities
      @activities += dep
    end
    @activities = @activities + Activity.where(['activities.department_id IS NULL'])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])
    @departments = Department.all
    respond_to do |format|
      format.html { } # edit.html.erb
    end
  end
  
  def new  
    @departments = current_user.organization.departments.all
    @activity = Activity.new
    
    respond_to do |format|
      format.html { } # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end
  
  
  # POST /activity
  # POST /activity.xml
  def create
    @activity = Activity.new(params[:activity])
    respond_to do |format|
      if @activity.save
        #Kairos.welcome_message(@person).deliver
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(activities_url) }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        flash[:warning] = 'Please check every information that you are entering and fill the required fields.'
        format.html { render :new }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /activity/1
    # PUT /activity/1.xml
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to activities_url }
        format.xml  { head :ok }
      else
        flash[:warning] = 'Please check every information that you are entering and fill the required fields.'
        format.html { render :edit }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /activity/1
   def destroy
     @activity = Activity.find(params[:id])
     @activity.destroy

     flash[:notice] = 'The activity has been deleted'
     redirect_to(activities_url)
   end    
   
   def deactivate
    activity = Activity.find(params[:id])
    activity.is_active = false
    SpecificActivity.deactivate_specific_activities(activity.specific_activities)
    
    activity.save!
    
    flash[:notice] = 'The activity has been deactivated'
    redirect_to(activities_url)
   end
   
   def activate
     activity = Activity.find(params[:id])
     activity.is_active = true
     SpecificActivity.activate_specific_activities(activity.specific_activities)

     activity.save!

     flash[:notice] = 'The activity has been activated'
     redirect_to(activities_url)   
   end   
end
