class Climate < Element
  def self.model_name
    Element.model_name
  end

  def set_type
    self.type = "Climate"
  end
end
