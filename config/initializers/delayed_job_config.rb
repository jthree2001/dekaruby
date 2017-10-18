Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 7.days
Dir["#{Rails.root}/lib/workers/*.rb"].each {|file| require file }
Dir["#{Rails.root}/lib/workers/homeassistant/*.rb"].each {|file| require file }
Dir["#{Rails.root}/app/models/elements/*.rb"].each {|file| require file }
Rails.application.configure do
  config.autoload_paths += %W(#{Rails.root}/app/models/elements)
end
