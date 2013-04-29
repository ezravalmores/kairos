class ApprovalsController < ApplicationController
  before_filter :is_sup_add, :clear_sessions
  
  def tasks_approval
    if current_user.is_supervisor?
      @persons = Person.collect_people_in_my_department(current_user.department_id)
      @activities = PersonTime.collect_each_person_activities(@persons,'approval',Date.today,Date.today)
    elsif current_user.is_admin?
      @persons = Person.all
      @activities = PersonTime.collect_each_person_activities(@persons,'approval',Date.today,Date.today)
    end
    respond_to do |format|
      #@activities_submitted = PersonTime.submitted.not_yet_approved
    
      format.html # index.html.erb
      #format.xml  { render :xml => @people }
    end
  end
  
  def leaves_approval
     @people_can_receive_emails = Person.where(:can_receive_mails => true)
     leaves = UserLiv.is_submitted.is_not_approved.is_active.is_not_canceled
     canceled_leaves = UserLiv.is_active.is_canceled
     @persons = Person.collect_people_in_my_department(current_user.department_id)
     
     if current_user.is_supervisor?
        @leaves = leaves.where(:person_id => @persons.map{|l| l.id})
     elsif current_user.is_admin?
        @leaves = leaves
    end
  end   
  
  def canceled_leaves_approval
    @people_can_receive_emails = Person.where(:can_receive_mails => true)
    canceled_leaves = UserLiv.is_active.is_canceled
    @persons = Person.collect_people_in_my_department(current_user.department_id)
     
     if current_user.is_supervisor?
       @canceled_leaves = canceled_leaves.where(:person_id => @persons.map{|l| l.id})
     elsif current_user.is_admin?
      @canceled_leaves = canceled_leaves
     end    
  end  
end
