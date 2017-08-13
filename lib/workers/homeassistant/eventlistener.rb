class EventListener < HomeAssistantBase

  def initialize()
    super
  end

  def perform()
    @homeassistant_info = {url: Rails.application.secrets.homeassistant[:url], port: Rails.application.secrets.homeassistant[:port], password: Rails.application.secrets.homeassistant[:password]}
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
    puts "new message: #{message}"
  end
end
