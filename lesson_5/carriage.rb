require_relative('manufacturer')
class Carriage
  include Manufacturer
  include InstanceCounter
  attr_reader :number
  attr_accessor :owner
  
  def initialize(number)
    @number = number
    register_instance
  end

  def to_s
    result = "Carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end
end
