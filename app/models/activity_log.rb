class ActivityLog < ActiveRecord::Base
  belongs_to :activity_log_type, :polymorphic => true
  belongs_to :person
  
  scope :people_involved_not_null, where(["activity_logs.people_involved <> ''"])
  scope :people_involved_null, where(["activity_logs.people_involved IS NULL"])
  
  #class methods
  def self.check_coming_activity_group
    dt = Date.today + 3.days
    where(["activity_logs.date <=? AND activity_logs.is_active =? AND activity_logs.has_created_notifications =?",dt.strftime("%y-%m-%d"),true,false])
  end
  
  def self.check_coming_activity_individual
     dt = Date.today + 3.days
     where(["activity_logs.date <=? AND activity_logs.is_active =? AND activity_logs.has_created_notifications =?",dt.strftime("%y-%m-%d"),true,false])
   end
end  