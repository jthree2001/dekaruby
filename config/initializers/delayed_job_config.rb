Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 5.minutes
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/homeassistant/*.rb'].each {|file| require file }
