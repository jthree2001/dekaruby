class Light < Element
  def self.model_name
    Element.model_name
  end

  def turn_on(color_name:"white", brightness_pct: "100")
    get_homeassistant_creds
    body_builder ='{"entity_id": "'+ self.entity_id+'", "color_name": "'+color_name+'", "brightness_pct": "'+brightness_pct+'"}'
    url = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/services/light/turn_on"
    api_call_post url, body_builder
  end

  def turn_off
    get_homeassistant_creds
    body_builder ='{"entity_id": "'+ self.entity_id+'"}'
    url = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/services/light/turn_off"
    api_call_post url, body_builder
  end
end
