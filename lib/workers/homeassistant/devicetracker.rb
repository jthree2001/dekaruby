class DeviceTrackerWorker < HomeAssistantBase

  def initialize(message)
    @message = JSON.parse(message)
  end

  def perform()
    element = Element.where(:entity_id => @message["data"]["entity_id"]).first
    element.set_location(@message["data"]["new_state"]["state"])
    puts "#{element.entity_id}: Tracker set to #{@message["data"]["new_state"]["state"]}" if element.save
  end
end
