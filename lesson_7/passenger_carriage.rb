require_relative('manufacturer')

class PassengerCarriage < Carriage;
  NOT_ENOUGH_SEATS = 'There\'s not enough free seats in carriage'
  
  def reserve_space
    @free_space -= 1
  end

  def to_s
    result = "Passenger carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result += ". #{@space} seats, #{free_space} free. "
    result
  end
end
