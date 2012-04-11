class LeavesController < ApplicationController
  
  before_filter :authorize
  
  def index

    respond_to do |format|
      #@activities_submitted = PersonTime.submitted.not_yet_approved
    
      format.html # index.html.erb
      #format.xml  { render :xml => @people }
    end
  end
end
