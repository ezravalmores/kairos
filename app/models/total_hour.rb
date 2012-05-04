class TotalHour < ActiveRecord::Base  
  belongs_to :person
  
  def self.save_utilization_rate(hours,minutes)
     total_minutes = (hours.to_i * 60) + minutes.to_i
      total_hours = 390
      total = (total_minutes.to_i / 390.00) * 100
      total
   
  end
  
  
end  