namespace :kairos do
desc "tasks for leaves"
task :deduct_active_leaves => :environment do
 UserLiv.deduct_leaves
end
end