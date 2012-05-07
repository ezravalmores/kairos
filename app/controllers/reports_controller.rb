class ReportsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_filter :authorize
  
  def generate_spreadsheets
     spreadsheets = {}
    #if !params[:from_date].blank? || !params[:to_date].blank?
      tasks = PersonTime.search_task(session[:from_date],session[:to_date],session[:department_id],session[:person_id],session[:activity_id]) 
    #end  
     if tasks.count == 0 
       flash[:warning] = "No results was found"
     else
       template = "reports/tasks_report.xls.eku"

         @tasks = tasks
         @report_type = "tasks_report"
         spreadsheets["tasks_report.xls"] = 
         render_to_string(:template => template,:layout => false)
  
         public_filename = Archiver.bundle(spreadsheets,@report_type)
         
         send_file(File.join("public",public_filename), :disposition => 'attachment') 
       flash[:notice] = "Spreadsheet has been successfuly processed"   
     end    
  end  
  
  def child_sponsorships_graph
   
    @persons = Person.collect_people_in_my_department(current_user.department_id)
    
    if params[:from_date].nil? && params[:to_date].nil?  
      @activities = PersonTime.collect_each_person_activities(@persons,'activities',Date.today,Date.today)
      @series = current_user.activity_series(@persons,'activities',Date.today,Date.today)
      
    else
    @activities = PersonTime.collect_each_person_activities(@persons,'activities',params[:from_date],params[:to_date])
    @series = current_user.activity_series(@persons,'activities',params[:from_date],params[:to_date])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end        
  end
  
  def tasks_report
    #if !params[:from_date].nil? || !params[:to_date].nil?
    @tasks = PersonTime.search_task(params[:from_date],params[:to_date],params[:department_id],params[:person_id],params[:activity_id])  
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    session[:department_id] = params[:department_id]
    session[:person_id] = params[:person_id]
    session[:activity_id] = params[:activity_id]
    #end
  end 
  
  def search_tasks
    @search = Search.new(params[:date])
    @tasks = @search.find_tasks
    
    respond_to do |format|
       format.html # tasks_report.html.erb
       #format.xml  { render :xml => @people }
     end
  end 
  
  def utilization_rate_report
    if !params[:from_date].blank? && !params[:to_date].blank? && !params[:person_id].blank?
      @total_hours = TotalHour.search_rate(params[:person_id],params[:from_date],params[:to_date])
 
      diff = params[:to_date].to_date - params[:from_date].to_date

      days = diff.day.to_i / 1440 / 60
      
      if days == 0
        @total_utilization = number_with_precision(@total_hours.sum(:total_utilization_rate) / 1, :precision => 2)
      else
        @total_utilization = number_with_precision(@total_hours.sum(:total_utilization_rate) / days.to_i, :precision => 2)
      end
          
      session[:from_date] = params[:from_date]
      session[:to_date] = params[:to_date]
      
    end
  end    
end
