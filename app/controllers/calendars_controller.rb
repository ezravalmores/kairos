class CalendarsController < ApplicationController
  
  def index
    respond_to do |format|
      @leaves = UserLiv.find(:all)
      #@samples = Sample.find(:all)
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
    
      format.html # index.html.erb
      format.xml  { render :xml => @leaves}
    end
  end  
end  