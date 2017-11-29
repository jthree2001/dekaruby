class Element < ApplicationRecord

  def get_history(timestamp: nil)
    # NOTE (Michael): Exmaple date format "2016-02-06T22:15:00+00:00", if not passed in, only returns the day before
    get_homeassistant_creds
    url_builder = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/history/period"
    url_builder += "/#{timestamp}" unless timestamp.blank?
    url_builder += "?filter_entity_id=#{self.entity_id}"

    return api_call_get(url_builder)
  end

  def test_me
    puts "Hello world"
    return "Hello world"
  end

  def set_type
    raiser "You must override this method in each model inheriting from Product!" if self.type.blank?
  end

  def get_state
    get_homeassistant_creds
    url_builder = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/states/#{self.entity_id}"

    return JSON.parse(api_call_get(url_builder))
  end

  def get_simple_state
    state_hash = get_state
    return state_hash["state"]
  end

  def set_state(state, extra_states:nil)
    # NOTE (Michael): Extra states come in as string and gets tacked on at the end
    url_builder = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/states/#{self.entity_id}"
    body_builder = '{ "state":'+"#{state}"
    body_builder += extra_states unless extra_states.blank?
    body_builder += "}"
  end

  def get_homeassistant_creds
    @homeassistant_info = { url: Rails.application.secrets.homeassistant[:url],
                            port: Rails.application.secrets.homeassistant[:port],
                            password: Rails.application.secrets.homeassistant[:password]}
  end

  def api_call_get(url)
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"x-ha-access" => @homeassistant_info[:password]}) unless @homeassistant_info[:password].blank?
    return http.request(request).read_body
  end

  def api_call_post(url, requestbody)
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    if @homeassistant_info[:password].blank?
      request = Net::HTTP::Post.new(uri.request_uri)
    else
      #request["x-ha-access"] = @homeassistant_info[:password]}) unless @homeassistant_info[:password].blank?
      request = Net::HTTP::Post.new(uri.request_uri, initheader: {'x-ha-access' => @homeassistant_info[:password]})
    end

    request.body = requestbody
    return http.request(request).read_body
  end
end
