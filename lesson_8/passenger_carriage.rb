require_relative('manufacturer')

class PassengerCarriage < Carriage
  def reserve_space
    super(1)
  end

  def to_s
    result = "Passenger carriage №#{number}"
    result << ", made by #{manufacturer}" unless manufacturer.empty?
    result << ". #{@space} seats, #{free_space} free"
    result
  end
end
