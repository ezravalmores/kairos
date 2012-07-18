require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every '2m' do
  # every day of the week at 22:00 (10pm)
  UserLiv.deduct_leaves
end