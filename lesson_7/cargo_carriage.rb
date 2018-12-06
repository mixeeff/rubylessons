require_relative('manufacturer')

class CargoCarriage < Carriage;
  attr_reader :volume, :free_volume

  WRONG_VOLUME = 'Volume must be more than zero'
  VOLUME_TOO_BIG = 'Reserving volume is more than carriage\'s volume'

  def initialize(number, volume)
    @number = number
    @volume = volume
    @free_volume = volume
    validate!
    register_instance
  end

  def reserve_volume(volume)
    raise VOLUME_TOO_BIG if volume > @free_volume
    @free_volume -= volume
  end

  def reserved_volume
    @volume - @free_volume
  end

  def to_s
    result = "Cargo carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result += ". #{@volume} sq.meters, #{free_volume} sq.meters free."
    result
  end

  protected

  def validate!
    super
    raise WRONG_VOLUME if volume <= 0
  end 
end
