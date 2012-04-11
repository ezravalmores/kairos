module ReportHelper
  def options_for_team
    departments = Department.all
    container = departments
  end
  
  def options_for_team
    departments = Department.all
    container = departments
  end
  
  def options_for_person
    people = Person.all
    container = people
  end
  
  def options_for_report_activity
    activities = Activity.all
    container = activities
  end
end
