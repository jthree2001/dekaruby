class BinarySensor < Element
  def self.model_name
    Element.model_name
  end
  def set_type
    self.type = "BinarySensor"
  end
end
