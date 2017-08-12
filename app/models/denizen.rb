class Denizen < ApplicationRecord

  def is_home?
    if self.location == "home"
      return true
    else
      return false
    end
  end
end
