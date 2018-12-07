require_relative('manufacturer')

class PassengerCarriage < Carriage;  
  def reserve_space
    raise self.Class::NOT_ENOUGH_SPACE if @free_space == 0
    @free_space -= 1
  end

  def to_s
    result = "Passenger carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result += ". #{@space} seats, #{free_space} free. "
    result
  end
end
