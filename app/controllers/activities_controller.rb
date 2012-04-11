class ActivitiesController < ApplicationController
  before_filter :is_administrator
  
  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])
    
    respond_to do |format|
      format.html { } # edit.html.erb
    end
  end
  
  def new  
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
end
