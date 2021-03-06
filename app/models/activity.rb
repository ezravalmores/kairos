class Activity < ActiveRecord::Base
  has_many :person_times
  has_many :specific_activities
  belongs_to :department
  
  validates_presence_of :name
  
  scope :active, where(:is_active => true)
  scope :view_all, where(:can_view_to_all_org => true)
end
