class Activity < ActiveRecord::Base
  has_many :person_times
  has_many :specific_activities
  belongs_to :department
  
  validates_presence_of :name
end
