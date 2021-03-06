class SpecificActivitiesController < ApplicationController
  before_filter :is_sup_add, :clear_sessions
  
  def index
    org = current_user.organization.departments.all
    ids = org.map {|d| d.id}
    @specific_activities = []
    org.each do |dep|
      dep = dep.activities
      dep.each do |act|
        act = act.specific_activities
        @specific_activities += act
      end  
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @specific_activities }
    end
  end
  
  def edit
    @specific_activity = SpecificActivity.find(params[:id])
    
    respond_to do |format|
      format.html { } # edit.html.erb
    end
  end
  
  def new  
    @specific_activity = SpecificActivity.new
    org = current_user.organization.departments.all
    ids = org.map {|d| d.id}
    @activities = []
    org.each do |dep|
      dep = dep.activities
      @activities += dep
    end
    respond_to do |format|
      format.html { } # new.html.erb
      format.xml  { render :xml => @specific_activity }
    end
  end
  
  
  # POST /activity
  # POST /activity.xml
  def create
    @specific_activity = SpecificActivity.new(params[:specific_activity])
    respond_to do |format|
      if @specific_activity.save
        #Kairos.welcome_message(@person).deliver
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(specific_activities_url) }
        format.xml  { render :xml => @specific_activity, :status => :created, :location => @specific_activity }
      else
        flash[:warning] = 'Please check every information that you are entering and fill the required fields.'
        format.html { render :new }
        format.xml  { render :xml => @specific_activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /activity/1
    # PUT /activity/1.xml
  def update
    @specific_activity = SpecificActivity.find(params[:id])

    respond_to do |format|
      if @specific_activity.update_attributes(params[:specific_activity])
        flash[:notice] = 'Specific Activity was successfully updated.'
        format.html { redirect_to specific_activities_url }
        format.xml  { head :ok }
      else
        flash[:warning] = 'Please check every information that you are entering and fill the required fields.'
        format.html { render :edit }
        format.xml  { render :xml => @specific_activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /activity/1
   def destroy
     @specific_activity = SpecificActivity.find(params[:id])
     @specific_activity.destroy

     flash[:notice] = 'The activity has been deleted'
     redirect_to(specific_activities_url)
   end
   
   def deactivate
     specific_activity = SpecificActivity.find(params[:id])
     specific_activity.deactivate

     flash[:notice] = 'The specific activity has been deactivated'
     redirect_to(specific_activities_url)
   end 
   
   def activate
      specific_activity = SpecificActivity.find(params[:id])
      specific_activity.activate

      flash[:notice] = 'The specific activity has been activated'
      redirect_to(specific_activities_url)
    end
end
