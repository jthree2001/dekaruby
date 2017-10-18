class Lock < Element
  def self.model_name
    Element.model_name
  end

  def set_type
    self.type = "Lock"
  end
end
