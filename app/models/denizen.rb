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
    return unlock_doors if access_level == 2
    if self.access_level == 1
      Denizen.all.each do |e|
        if e.access_level > 1
          return unlock_doors if e.location == "home"
        end
      end
    end
  end

  private
  def access_level
    return 2 if self.access == "admin"
    return 1 if self.access == "guest"
    return 0
  end

  def unlock_doors
    url_builder = "#{Rails.application.secrets.homeassistant[:url]}:#{Rails.application.secrets.homeassistant[:port]}/api/services/lock/unlock"

    uri = URI.parse(url_builder)
    http = Net::HTTP.new(uri.host, uri.port)
    http['x-ha-access'] = Rails.application.secrets.homeassistant[:password] unless Rails.application.secrets.homeassistant[:password].blank?
    header = {'Content-Type': 'text/json'}
    request = Net::HTTP::Post.new(uri.request_uri, header)
    # request.body = user.to_json
    # Send the request
    response = http.request(request)
  end
end
