class EventListener < HomeAssistantBase

  def initialize()
    super
  end

  def perform()
    url_builder = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/stream"
    puts url_builder
    EM.run do
      source = EventMachine::EventSource.new(url_builder)
      source.message do |message|
        react(message)
      end
      source.start # Start listening
    end
  end

  def react(message)
    unless message == "new message: ping"
      parsed = JSON.parse(message)
      type = parsed["data"]["entity_id"].split(".")[0]
      if type == "device_tracker"
        Delayed::Job.enqueue(DeviceTracker.new(message))
      end
    else
      puts "ping received"
    end
  end
end
