require_relative('manufacturer')
class PassengerCarriage < Carriage;
  def to_s
    result = "Passenger carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end 
end
