Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 7.days
Dir["#{Rails.root}/lib/workers/*.rb"].each {|file| require file }
Dir["#{Rails.root}/lib/workers/homeassistant/*.rb"].each {|file| require file }
