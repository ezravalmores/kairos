class Department < ActiveRecord::Base
  has_many :people
  has_many :specific_activity
  has_many :activities
end
