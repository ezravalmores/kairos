class SpecificActivity < ActiveRecord::Base
  belongs_to :department
  belongs_to :activity
  has_many :person_times
  
  validates_presence_of :name, :activity
end
