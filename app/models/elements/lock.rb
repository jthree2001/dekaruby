class Lock < Element
  def self.model_name
    Element.model_name
  end

  def set_type
    self.type = "Lock"
  end

  def unlock
    get_homeassistant_creds
    body_builder ='{"entity_id": "lock.front_door"}'
    url = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/services/lock/unlock"
    api_call_post url, body_builder
  end

  def lock
    get_homeassistant_creds
    body_builder ='{"entity_id": "'+ self.entity_id+'"}'
    url = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/services/lock/lock"
    api_call_post url, body_builder
  end
end
