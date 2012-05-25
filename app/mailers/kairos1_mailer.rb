class Kairos1Mailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome_message(person)
    @person = person

    mail(:to => person.email_address, :from => "Kairos <reports@ncm.org>", :subject => "Welcome to Kairos")
  end
  
  def send_to_selected(person)
    @person = person

    mail(:to => person.email_address, :from => "Kairos <reports@ncm.org>", :subject => "Tasks Approvals")
  end 
  
  def send_approvals(person,submitted_by)
    @submitted_by = submitted_by
    @to = person
     #for person in people 
        @person = person
        mail(:to => person.email_address, :from => "Kairos <reports@ncm.org>", :subject => "Tasks Approvals")
    #end    
  end   
end
