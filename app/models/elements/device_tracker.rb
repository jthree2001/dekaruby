class DeviceTracker < Element

  def self.model_name
    Element.model_name
  end

  def owner_name
    unless self.denizen_id.blank?
      return Denizen.find(self.denizen_id).full_name
    else
      return nil
    end
  end

  def set_location(location)
    set_owner_location(location)
    self.location = location
    self.save
  end

  def set_type
    self.type = "DeviceTracker"
  end

  private
  def set_owner_location(location)
    unless self.denizen_id.blank?
      owner = Denizen.find(self.denizen_id)
      owner.set_location(location)
      if owner.save
        return true
      else
        return false
      end
    else
      return nil
    end
  end
end
