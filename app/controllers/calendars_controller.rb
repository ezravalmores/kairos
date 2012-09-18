class CalendarsController < ApplicationController
  
  def index
     session[:leaves] = 'none'
      session[:time] = 'none'
      session[:calendar] = 'active'
      session[:approvals] = 'none'
      session[:reports] = 'none'
      session[:admin] = 'none'
    respond_to do |format|
      @leaves = ActivityLog.find(:all)
      #@samples = Sample.find(:all)
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      @people = Person.can_see_leaves_notifications(current_user.department_id)
      
      format.html # index.html.erb
      format.xml  { render :xml => @leaves}
    end
  end  
end  