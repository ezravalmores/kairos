require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every '2m' do
  # every day of the week at 22:00 (10pm)
  UserLiv.deduct_leaves
  activities_group = ActivityLog.check_coming_activity_group.people_involved_not_null
  
  if activities_group.count > 0
    activities_group.each do |activity|
      person_ids = activity.people_involved  
      people = Person.where(:id => person_ids.split(',')) 
      people.each do |person|
        Notification.create!(:person_id => person.id,:activity_log_id => activity.id, :notification_log_type_type => activity.activity_log_type_type, :notification_log_type_id => activity.activity_log_type_id)
      end
    #Notification.create!(:person_id => activity.person_id,:activity_log_id => activity.id, :notification_log_type_type => activity.activity_log_type_type, :notification_log_type_id => activity.activity_log_type_id)  
    activity.has_created_notifications = true
    activity.save!  
    end
  end
  
 # activities = ActivityLog.check_coming_activity_individual.people_involved_null
  
  #if activities.count > 0
   # activities.each do |activity|
    #  Notification.create!(:person_id => activity.person_id,:activity_log_id => activity.id, :notification_log_type_type => activity.activity_log_type_type, :notification_log_type_id => activity.activity_log_type_id)

     # activity.has_created_notifications = true
    #  activity.save!  
    #end
  #end
end

