# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
require "#{Rails.root}/config/initializers/delayed_job_config.rb"
Dir["#{Rails.root}/app/models/elements/*.rb"].each {|file| require file }
