class NcmmActivitiesController < ApplicationController
  before_filter :authorize
  
  def index
    
  end
  
  def edit
    
  end
  
  def show
    
  end
  
  def create_activity
    unless params[:from_date].blank? || params[:to_date].blank? || params[:activity].blank? || params[:description].blank? || params[:person_id].blank? || params[:people].blank?
      unless params[:from_date].to_date.year > Date.today.year || params[:to_date].to_date.year > Date.today.year
        unless params[:to_date].to_date < params[:from_date].to_date
          days = params[:to_date].to_date - params[:from_date].to_date + 1
          day = params[:from_date].to_date
          week = params[:from_date].to_date - 7.days
          people = Person.find(params[:people])
          
          days.to_i.times do
            activity = NcmmActivity.create!(:date => day,:activity=> params[:activity],:description => params[:description],:person_id => params[:person_id])
            day = day + 1.day 
            ActivityLog.create!(:person_id => activity.person_id, :date => activity.date, :activity_log_type_type => "NcmmActivity", :activity_log_type_id => activity.id, :people_involved => people.map {|p| p.id}.join(","))
          end  


          flash[:notice] = "Request for leave successfully created"
        else
          flash[:warning] = "Sorry, end of leave can't be less than the start of leave"
        end    
      else
        flash[:warning] = "Sorry, You can't create a leave greater than this year"
      end    
    else
      flash[:warning] = "Sorry, You must fill out all required fields"
    end
    respond_to do |format|
      format.html { redirect_to :back}
    end
  end
  
  def update
    
  end
  
  def destroy
    
  end            
end  