class Climate < Element
  def self.model_name
    Element.model_name
  end

  def set_type
    self.type = "Climate"
  end

 def set_temperature(temperature)
   get_homeassistant_creds
   body_builder ='{"entity_id": "'+ "#{self.entity_id}" +'",  "temperature": "'+ "#{temperature}" +'" }'
   url = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/services/climate/set_temperature"
   api_call_post url, body_builder
 end
end
