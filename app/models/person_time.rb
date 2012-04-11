class PersonTime < ActiveRecord::Base
  belongs_to :person
  belongs_to :activity
  belongs_to :role
  belongs_to :specific_activity
  
  # validations
  validates_presence_of :start_time
  
  scope :not_yet_ended, where(["person_times.created_at >= ? AND person_times.end_time IS NULL",Date.today.beginning_of_day])
  scope :user_activities_today, where(["person_times.created_at >?",Date.today.yesterday.end_of_day])
  scope :submitted, where(:is_submitted => true)
  scope :not_yet_approved, where(['person_times.is_approved IS NULL'])
  scope :approved, where(['person_times.is_approved IS NOT NULL'])
  scope :not_include_end_shift, where("activities.name != 'End Shift'").includes(:activity) 
  scope :by_date, lambda { |*date| where(["(person_times.created_at >=? AND person_times.created_at <=?)",date.first,date.second]) }
  # scope :department_people, joins(:person).merge(Person.people_in_my_department)
  
  def self.collect_each_person_activities(persons,this_for=nil,from_date,to_date)
    activities = []
    persons.each do |person|
      if this_for == 'approval'
        activities += person.person_times.submitted.not_yet_approved
      else
        activities += person.person_times.approved.not_include_end_shift.by_date(from_date,to_date)
      end  
    end
    activities
  end

  def self.activity_series(activities_set,this_for,from_date,to_date)
    summary = connection.select_all(
    self.select("activities.name,count(activity_id) count").joins(:activity).group(:activity_id).to_sql)
     
    summary.reverse.map {|activity| [activity["name"].to_s,activity["count"].to_i] }.inspect.html_safe
  end
    
  def self.search_user_activity_not_yet_ended_today(user_id)
    where(["person_times.created_at >=? AND person_times.end_time IS NULL AND person_times.person_id =?",Date.today.beginning_of_day,user_id])
  end  
  
  def self.search_by_date(date)
    where(["person_times.created_at <? AND person_times.created_at >?",date.end_of_day,date.yesterday.end_of_day])
  end  
  
  def self.search_task(from,to,team_id,person_id,task_id)
    tasks = []
    persons = []
    if !from.blank? || !to.blank?
      tasks = where(["person_times.created_at >? AND person_times.created_at <?",from.to_date.beginning_of_day,to.to_date.end_of_day])  
      if !team_id.blank?
        people = Person.where(:department_id => team_id)
        persons = people.map {|p| p.id}
        tasks = tasks.where(:person_id => persons)
      end  
      
      tasks = tasks.where(["person_times.person_id =?",person_id]) if !person_id.blank? 
      tasks = tasks.where(["person_times.activity_id =?",task_id]) if !task_id.blank?
    elsif !team_id.blank?
      people = Person.where(:department_id => team_id)
      persons = people.map {|p| p.id}
      tasks = where(:person_id => persons)
        
      tasks = tasks.where(["person_times.person_id =?",person_id]) if !person_id.blank?
      tasks = tasks.where(["person_times.activity_id =?",task_id]) if !task_id.blank?
      tasks = tasks.where(["person_times.created_at >? AND person_times.created_at <?",from.to_date.beginning_of_day,to.to_date.end_of_day]) if !from.blank? || !to.blank?   
    elsif !person_id.blank?
      
      tasks = where(["person_times.person_id =?",person_id]) 
      if !team_id.blank?
        people = Person.where(:department_id => team_id)
        persons = people.map {|p| p.id}
        tasks = tasks.where(:person_id => persons)
      end
      
      tasks = tasks.where(["person_times.activity_id =?",task_id]) if !task_id.blank?
      tasks = tasks.where(["person_times.created_at >? AND person_times.created_at <?",from.to_date.beginning_of_day,to.to_date.end_of_day]) if !from.blank? || !to.blank?
    elsif !task_id.blank?
      tasks = where(["person_times.activity_id =?",task_id]) 
      
      if !team_id.blank?
        people = Person.where(:department_id => team_id)
        persons = people.map {|p| p.id}
        tasks = tasks.where(:person_id => persons)
      end
      tasks = tasks.where(["person_times.created_at >? AND person_times.created_at <?",from.to_date.beginning_of_day,to.to_date.end_of_day]) if !from.blank? || !to.blank?
      tasks = tasks.where(["person_times.person_id =?",person_id]) if !person_id.blank?
    end 
    tasks
  end  
  
  def self.other_user_activities_today(user_id)
    where(["person_times.person_id !=? AND person_times.end_time IS NOT NULL and person_times.activity_id IS NOT NULL",user_id])
  end  
  
  def self.get_breaks(id)
    where(["person_times.activity_id =?",id])
  end
  
  def self.get_productive_hours
    personal_id = Activity.find_by_name("Personal Time").id
    break_id = Activity.find_by_name("Break").id
    avail_id = Activity.find_by_name("Avail Time")
    where(["person_times.activity_id !=? AND person_times.activity_id !=? AND person_times.activity_id !=?",break_id,personal_id,avail_id])
  end
  
  # Sets a activity's :is_submitted column to true
  def submit_activity(updated_by)
    update_attributes({:is_submitted => true, :updated_by => updated_by})
  end
  
  def self.submit_activities(updated_by,activityset)
    activities = find(activityset)
    
    transaction do
      activities.each do |activity|
        submitted = activity.submit_activity(updated_by)
      end
    end
  end
  
  def approve_activity(approved_by)
    update_attributes({:is_approved => true, :updated_by => approved_by, :approved_by => approved_by })
  end
  
  def self.approve_activities(approved_by,activityset)
    activities = find(activityset)
    
    transaction do
      activities.each do |activity|
        submitted = activity.approve_activity(approved_by)
      end
    end
  end
  
  def self.calculate_total_hours(ids,show=nil)
   # ids = activities.map {|c| c.id}
    hours = 0
    minutes = 0
    seconds = 0
    activities = find(ids)
    activities.each do |f|
      
      should_change_seconds = "false"
      should_change_minutes = "false" 
      
      seconds += f.total_time.strftime('%S').to_i if !f.total_time.nil?
      if seconds >= 60
        should_change_seconds = "true"
      end
      minutes += f.total_time.strftime('%M').to_i if !f.total_time.nil?
      if minutes >= 60
        should_change_minutes = "true" 
      end 
      if should_change_seconds == "true" 
        minutes += 1
        seconds = seconds - 60
      end
      if should_change_minutes == "true" 
        hours += 1
        minutes = minutes - 60
      end
      hours += f.total_time.strftime('%H').to_i if !f.total_time.nil?     
    end
    if show =="hours"
      hours
    elsif show =="minutes"
      minutes
    else
      seconds  
    end
  end
  
  def is_submitted?
    is_submitted == true
  end
  
  def is_approved?
    is_approved == true
  end 
end
