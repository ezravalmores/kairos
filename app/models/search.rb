class Search
  attr_accessor :activity_id
  attr_accessor :from
  
  def find_tasks
    tasks = PersonTime.where("person_times.created_at >?", from)  
    tasks  
  end
    
end  