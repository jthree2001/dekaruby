# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Dir["#{Rails.root}/lib/workers/*.rb"].each {|file| require file }
Dir["#{Rails.root}/lib/workers/homeassistant/*.rb"].each {|file| require file }
