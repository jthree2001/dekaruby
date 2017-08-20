class Element < ApplicationRecord
  # belongs_to :denizen
  scope :DeviceTracker, -> { where(element_type: "DeviceTracker")}
  scope :Automation, -> { where(element_type: "Automation")}
  scope :BinarySensor, -> { where(element_type: "BinarySensor")}
  scope :Climate, -> { where(element_type: "Climate")}
  scope :Configurator, -> { where(element_type: "Configurator")}
  scope :Group, -> { where(element_type: "Group")}
  scope :Light, -> { where(element_type: "Light")}
  scope :MediaPlayer, -> { where(element_type: "MediaPlayer")}
  scope :Scene, -> { where(element_type: "Scene")}
  scope :Sensor, -> { where(element_type: "Sensor")}
  scope :Sun, -> { where(element_type: "Sun")}
  scope :Switch, -> { where(element_type: "Switch")}
  scope :Updater, -> { where(element_type: "Updater")}
  scope :Zone, -> { where(element_type: "Zone")}
  self.inheritance_column = :element_type

  def get_history(timestamp: nil)
    # NOTE (Michael): Exmaple date format "2016-02-06T22:15:00+00:00", if not passed in, only returns the day before
    get_homeassistant_creds
    url_builder = "#{@homeassistant_info[:url]}:#{@homeassistant_info[:port]}/api/history/period"
    url_builder += "/#{timestamp}" unless timestamp.blank?
    url_builder += "?filter_entity_id=#{self.entity_id}"

    return api_call_get(url_builder)
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

  private
  def get_homeassistant_creds
    @homeassistant_info = { url: Rails.application.secrets.homeassistant[:url],
                            port: Rails.application.secrets.homeassistant[:port],
                            password: Rails.application.secrets.homeassistant[:password]}
  end

  def api_call_get(url)
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http['x-ha-access'] = @homeassistant_info[:password] unless @homeassistant_info[:password].blank?
    request = Net::HTTP::Get.new(uri.request_uri)
    return http.request(request).read_body
  end

  def api_call_post()
  end
end
