require_relative('manufacturer')
class Carriage
  include Manufacturer
  include InstanceCounter
  set_instance_counter
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

class PassengerCarriage < Carriage;
  set_instance_counter
  def to_s
    result = "Passenger carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end 
end

class CargoCarriage < Carriage;
  set_instance_counter
  def to_s
    result = "Cargo carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end  
end
