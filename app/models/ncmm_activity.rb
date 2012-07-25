class NcmmActivity < ActiveRecord::Base
  belongs_to :person
  has_one :activity_log, :as => :activity_log_type, :dependent => :destroy
end  