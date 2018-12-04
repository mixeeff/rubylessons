require_relative('manufacturer')

class CargoCarriage < Carriage;
  def to_s
    result = "Cargo carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end  
end
