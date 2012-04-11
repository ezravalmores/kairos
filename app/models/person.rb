class Person < ActiveRecord::Base
  has_many :person_times
  belongs_to :role
  belongs_to :department
  
  # Validations
  validates_presence_of :first_name, :last_name, :email_address, :password, :username
  validates_format_of :email_address, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i
  validates_uniqueness_of :email_address
  
  #scope :people_in_my_department,  lambda { |date| where(["(people.department_id =?",date]) }
  
  def activity_series(persons,this_for,from_date,upto_date)
    summaries = []
    persons.each do |person|    
    summaries += connection.select_all(
      person.person_times.approved.not_include_end_shift.by_date(from_date.to_date.beginning_of_day,upto_date.to_date.end_of_day).select("activities.name,count(activity_id) count").joins(:activity).group(:activity_id).to_sql)
    end 
    summaries.reverse.map {|activity| [activity["name"].to_s,activity["count"].to_i] }.inspect.html_safe
  end
  
  # Class methods
  def self.authenticate(username,password)
    find_by_username_and_password(username.downcase,password)
  end
  
  def self.collect_people_in_my_department(dep_id)
     where(['people.department_id =?',dep_id])
  end
  
  def is_admin?
    (!role.nil? && role.name == 'Administrator')
   end

  def is_supervisor?
    (!role.nil? && role.name == 'Supervisor')
  end 
  
  def interests_for(type)
    interests.select {|o| o.interest_type.name.downcase == type.to_s.downcase}
  end
  
end
