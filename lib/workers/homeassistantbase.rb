class HomeAssistantBase
  Dir["#{Rails.root}/app/models/elements/*.rb"].each {|file| require file }

  def initialize()
    @homeassistant_info = {url: Rails.application.secrets.homeassistant[:url], port: Rails.application.secrets.homeassistant[:port], password: Rails.application.secrets.homeassistant[:password]}
  end
end
