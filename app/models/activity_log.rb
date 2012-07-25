class ActivityLog < ActiveRecord::Base
  belongs_to :activity_log_type, :polymorphic => true
  belongs_to :person
end  