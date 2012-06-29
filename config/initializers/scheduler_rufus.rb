require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.cron '0 0 * * *' do
  # every day of the week at 22:00 (10pm)
  UserLiv.deduct_leaves
end