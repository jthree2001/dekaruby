class EventListener < HomeAssistantBase

  def initialize()
    super
  end

  def perform()
    url_builder = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/stream"
    EM.run do
      source = EventMachine::EventSource.new(url_builder)
      source.message do |message|
        react(message)
      end
      source.start # Start listening
    end
  end

  def react(message)
    puts "new message: #{message}"
  end
end
