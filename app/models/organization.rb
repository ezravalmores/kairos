class Organization < ActiveRecord::Base
  has_many :department
  has_many :specific_activities
  has_many :people
  
  validates_presence_of :name
  
end
