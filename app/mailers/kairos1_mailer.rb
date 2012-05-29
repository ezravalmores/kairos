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
end
