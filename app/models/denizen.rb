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
      # Do something here to unlock door
    end
  end
end
