class Sun < Element
  def self.model_name
    Element.model_name
  end

  def hello
    puts "hello world"
  end
end
