require_relative('manufacturer')

class PassengerCarriage < Carriage;
  attr_reader :seats, :free_seats

  WRONG_SEATS_NUMBER = 'Number of seats must be more than zero'

  def initialize(number, seats)
    @number = number
    @seats = seats
    @free_seats = seats
    validate!
    register_instance
  end

  def reserve_seat
    @free_seats -= 1
  end

  def reserved_seats
    @seats - @free_seats
  end

  def to_s
    result = "Passenger carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result += ". #{@seats} seats, #{free_seats} free. "
    result
  end

  protected

  def validate!
    super
    raise WRONG_SEATS_NUMBER if seats <= 0
  end 
end
