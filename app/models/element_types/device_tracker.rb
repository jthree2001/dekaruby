class DeviceTracker < Element

  def get_history(timestamp: nil)
    # NOTE (Michael): Exmaple date format "2016-02-06T22:15:00+00:00", if not passed in, only returns the day before
    get_homeassistant_creds
    url_builder = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/history/period"
    url_builder += "/#{timestamp}" unless timestamp.blank?
    url_builder += "?filter_entity_id=#{self.entity_id}"

    # return api_call_get(url_builder)
    return "I'm in the right one Michael"
  end
end
