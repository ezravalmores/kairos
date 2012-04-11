class Kairos1Mailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome_message(person)
    @person = person

    mail(:to => person.email_address, :from => "Kairos <reports@ncm.org>", :subject => "Welcome to NCM Child Sponsorship powered by Sprout")
  end
end
