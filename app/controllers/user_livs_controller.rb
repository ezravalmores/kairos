class UserLivsController < ApplicationController
  
  before_filter :authorize
  
  def index
    @person = current_user
    @leaves = @person.user_livs
    @leave = UserLiv.new
    @persons_can_approved = Person.persons_can_approve(current_user.department_id) + Person.get_admins
    
    respond_to do |format|
      #@activities_submitted = PersonTime.submitted.not_yet_approved
    
      format.html # index.html.erb
      format.xml  { render :xml => @leaves}
    end
  end
  
  def edit
    
  end  
  
  def update
    
  end
  
  def destroy
    @leave = UserLiv.find(params[:id])
    @leave.destroy

    flash[:notice] = 'The leave has been successfuly deleted'
    redirect_to :back
  end    
  
  def create
     @leave = UserLiv.new(params[:user_liv])
      #@activities = current_user.person_times
      respond_to do |format|
        if @leave.save
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
  
  def create_leave
  unless params[:from_date].blank? || params[:to_date].blank? || params[:leave_type_id].blank? || params[:reason].blank?
    unless params[:from_date].to_date.year > Date.today.year || params[:to_date].to_date.year > Date.today.year
      unless params[:to_date].to_date < params[:from_date].to_date
        days = params[:to_date].to_date - params[:from_date].to_date + 1
        day = params[:from_date].to_date
        week = params[:from_date].to_date - 7.days
        if Date.today <= week
          planned = true
        else
          planned = false  
        end  
        days.to_i.times do
          UserLiv.create!(:date => day,:leave_type_id => params[:leave_type_id],:reason => params[:reason],:with_pay => params[:with_pay],:planned => planned ,:person_id => current_user.id)
          day = day + 1.day 
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
  
  def submit_leaves
    if !params[:people].nil? && !params[:leaves].nil?
      leaves = params[:leaves]
      @leaves = UserLiv.find(leaves)
      people = Person.find(params[:people])
      
      UserLiv.submit_leaves(leaves)
      
      for person in people
        Kairos1Mailer.submit_leaves(person,current_user,@leaves).deliver
      end  
      
      flash[:notice] = "Request submitted successfully."
      
    else
      flash[:warning] = "Sorry, you need to select either people or the leaves in order to submit the leaves"  
    end  
    
    respond_to do |format|
      format.html { redirect_to :back}
    end
  end  
  
  def approve_leaves
    if params[:leaves].nil? || params[:people].nil?
      redirect_to :back
      flash[:warning] = "No Items were selected or No Person were selected, please select in the list."
    else      
      leaves = params[:leaves]
      @leaves = UserLiv.find(leaves)
      people = Person.find(params[:people]) 
      UserLiv.approve_leaves(current_user.id,leaves)
      
      for person in people
        Kairos1Mailer.send_mails(person,@leaves,current_user).deliver
      end
      
      for leave in @leaves
        Kairos1Mailer.send_mail_approvals_to_employee(leave.person.email_address,leave,current_user,leave.person).deliver
      end  
      
      redirect_to :back
      flash[:notice] = "Approvals Successfully made and it has sent email the human resource department"
    end
  end
  
  def approve_canceled_leaves
    if !params[:canceled_people].nil? || !params[:canceled_leaves].nil? 
      
    else  
      flash[:warning] = "Sorry, You need to select people and leaves in order to approved it."
    end
    redirect_to :back
  end  
  
  def cancel_leave
    leave = UserLiv.find(params[:id])
    leave.is_canceled = true
    leave.is_approved = false
    leave.save!
    
      persons_can_approve = Person.can_approve + Person.get_admins
      
      for person in persons_can_approve
        Kairos1Mailer.send_cancel_leave(person,leave,current_user).deliver
      end
    
    redirect_to :back
    flash[:notice] = "Your Leave was successfully cancelled."
  end    
end
