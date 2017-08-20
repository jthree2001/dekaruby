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
    puts "----#{message}-----"
    unless message == "ping"
      parsed = JSON.parse(message)
      unless Element.where(:entity_id => parsed["data"]["entity_id"]).blank?
        return false if parsed["data"]["entity_id"].blank?
        type = parsed["data"]["entity_id"].split(".")[0]
        element = Element.where(:entity_id => parsed["data"]["entity_id"]).first
        element.element_type = type.camelize
        element.save
        if type == "device_tracker"
          Delayed::Job.enqueue(DeviceTrackerWorker.new(message))
        end
      else
        element = Element.new()
        element.entity_id = parsed["data"]["entity_id"]
        element.element_type = parsed["data"]["entity_id"].split(".")[0] if parsed["data"]["entity_id"].blank?
        element.save
      end
    else
      puts "ping received"
    end
  end
end
