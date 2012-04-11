module PersonTimesHelper
  def check_overtime(person_time)
    dropdown = check_box_tag("activity",{ :id => "activity", :onchange => "updateActivity(this,\"#{update_is_overtime_person_times_url}\");" })
    #content_tag(:div,dropdown,:class => "process")
    dropdown
  end
  
  def options_for_activity(id)
    activities = Activity.where(['activities.department_id =? OR activities.department_id IS NULL',id])
    container = activities.all
  end
  
  def options_for_specific_activities(id)
     specific_activities = SpecificActivity.where(['specific_activities.department_id =? OR specific_activities.department_id IS NULL',id])
     container = specific_activities.all
  end
end
