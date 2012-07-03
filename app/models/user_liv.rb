class UserLiv < ActiveRecord::Base
  belongs_to :leave_type
  belongs_to :person
  
  #scopes
  scope :is_submitted, where(:is_submitted => true)
  scope :is_approved, where(:is_approved => true)
  scope :is_not_approved, where(:is_approved => false)
  scope :is_active, where(:is_active => true)
  scope :is_not_canceled, where(:is_canceled => false)
  scope :is_canceled, where(:is_canceled => true)
  
  #class methods
  def self.deduct_leaves #(vacation_leave,sick_leave)
    leaves = []
    leaves = where(["user_livs.is_active >=? AND user_livs.date <=? AND user_livs.is_approved =?",1,Date.today.end_of_day,1])
    
    for leave in leaves
      if leave.leave_type_id == 1
        leave.person.remaining_vacation_leave = leave.person.remaining_vacation_leave.to_i - 1
      elsif leave.leave_type_id == 2
        leave.person.remaining_sick_leave = leave.person.remaining_sick_leave.to_i - 1
      else
        dec = ".5"
        dec = dec.to_f
        leave.person.remaining_vacation_leave = leave.person.remaining_sick_leave.to_f - dec
      end
      leave.is_active = false
      leave.save  
      leave.person.save
    end  
  end  
  
  
  def submit_leave
    update_attributes({:is_submitted => true})
  end
  
  def self.submit_leaves(leaveset)
    leaves = find(leaveset)
    
    transaction do
      leaves.each do |leave|
        submitted = leave.submit_leave
      end
    end
  end
  
  def approve_leave(approved_by)
     update_attributes({:is_approved => true, :approved_by => approved_by })
  end
  
  def approve_canceled_leave(approved_by)
     update_attributes({:is_approved => true, :approved_by => approved_by, :is_active => false })
  end

   def self.approve_leaves(approved_by,leaveset)
     leaves = find(leaveset)

     transaction do
       leaves.each do |leave|
         submitted = leave.approve_leave(approved_by)
       end
     end
   end
   
   def self.approve_canceled_leaves(approved_by,leaveset)
      leaves = find(leaveset)

      transaction do
        leaves.each do |leave|
          submitted = leave.approve_canceled_leave(approved_by)
        end
      end
    end
end  