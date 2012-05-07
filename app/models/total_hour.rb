class TotalHour < ActiveRecord::Base  
  belongs_to :person
  
  def self.save_utilization_rate(hours,minutes)
     total_minutes = (hours.to_i * 60) + minutes.to_i
      total_hours = 390
      total = (total_minutes.to_i / 390.00) * 100
      total
   
  end
  
  def self.search_rate(user_id,from,to)
    rates = []
    if !from.blank? || !to.blank?
      rates = where(["total_hours.shift_date >=? AND total_hours.shift_date <=?",from.to_date.beginning_of_day,to.to_date.end_of_day])
      rates = rates.where(:person_id => user_id.to_i)
      rates
    end  
  end
end  