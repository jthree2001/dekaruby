class Denizen < ApplicationRecord

  def is_home?
    if self.location == "home"
      return true
    else
      return false
    end
  end

  def set_location(location)
    self.location = location
    if location == "home"
      give_access
    end
  end

  def give_access
    unlock_doors if access_level > 0
  end

  private
  def access_level
    return 1 if self.access == "admin"
  end
  
  def unlock_doors
    url_builder = "#{Rails.application.secrets.homeassistant[:url]}:#{Rails.application.secrets.homeassistant[:port]}/api/services/lock/unlock"

    uri = URI.parse(url_builder)
    http = Net::HTTP.new(uri.host, uri.port)
    http['x-ha-access'] = @homeassistant_info[:password] unless @homeassistant_info[:password].blank?
    header = {'Content-Type': 'text/json'}
    request = Net::HTTP::Post.new(uri.request_uri, header)
    # request.body = user.to_json
    # Send the request
    response = http.request(request)
  end
end
