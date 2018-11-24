class Carriage
  attr_reader :number
  attr_accessor :owner
  
  def initialize(number)
    @number = number
  end

  def to_s
    'Carriage №' + number
  end
end

class Passenger_carriage < Carriage;
  def to_s
    'Passenger carriage №' + number
  end 
end

class Cargo_carriage < Carriage;
  def to_s
    'Cargo carriage №' + number
  end  
end
