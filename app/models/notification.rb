class Notification < ActiveRecord::Base
  belongs_to :activity_log_type, :polymorphic => true
  belongs_to :notification_log_type, :polymorphic => true
  belongs_to :person
  
  #methods
  
  def self.unread_notifications(user)
     where(["notifications.has_read =? AND notifications.person_id =?",false,user.id])
  end  
  
  def self.read_notifications(user)
     where(["notifications.has_read =? AND notifications.person_id =?",true,user.id])
  end
end