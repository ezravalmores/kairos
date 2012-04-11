class ReportsController < ApplicationController
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
       #spawn do
         @tasks = tasks
         @report_type = "tasks_report"
         spreadsheets["tasks_report.xls"] = 
         render_to_string(:template => template,:layout => false)
         #render_to_string(:template => template,:layout => false)
         public_filename = Archiver.bundle(spreadsheets,@report_type)
       #end 
       flash[:notice] = "Spreadsheet has been successfuly processed"   
     end    
     redirect_to :back  
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
end
