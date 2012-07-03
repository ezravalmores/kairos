class Kairos1Mailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome_message(person)
    @person = person

    mail(:to => person.email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Welcome to Kairos")
  end
  
  def send_to_selected(person)
    @person = person

    mail(:to => person.email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Tasks Approvals")
  end 
  
  def send_approvals(person,submitted_by,shift_date)
    @submitted_by = submitted_by
    @to = person
    @shift_date = shift_date
     #for person in people 
        @person = person
        mail(:to => person.email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Tasks Approvals")
    #end    
  end 
  
  def submit_leaves(person,submitted_by,leaves)
    @submitted_by = submitted_by
    @leaves = leaves
    
    mail(:to => person.email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Leave(s) Approvals") 
  end
  
  def send_mails(person,leaves,current_user)
    @current_user = current_user
    @leaves = leaves
    @person = person
    
    mail(:to => person.email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Leave(s) Approved") 
  end 
  
  def send_mails_canceled(person,leaves,current_user)
    @current_user = current_user
    @leaves = leaves
    @person = person
    
    mail(:to => person.email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Leave(s) Canceled") 
  end
  
  def send_cancel_leave(person,leave,current_user)
    @current_user = current_user
    @leave = leave
    @person = person
    
    mail(:to => person.email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Canceled Leave") 
  end       
  
  def send_mail_approvals_to_employee(email_address,leave,current_user,person)
     @current_user = current_user
     @leave = leave
     @person = person
     
     mail(:to => email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Approved Leave") 
  end
  
  def send_mail_canceled_approvals_to_employee(email_address,leave,current_user,person)
     @current_user = current_user
     @leave = leave
     @person = person
     
     mail(:to => email_address, :from => "Kairos <no-reply@ncm.org>", :subject => "Canceled Leave") 
  end   
end
