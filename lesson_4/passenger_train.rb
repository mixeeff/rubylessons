class Passenger_train < Train
  def initialize(number)
    super
    @type = Railway::TRAIN_TYPES[0]
  end

  def to_s
    'Passenger train №' + number
  end

  def add_carriage(carriage)
    return unless carriage.class == Passenger_carriage
    super
  end

  def remove_carriage(carriage)
    return unless carriage.class == Passenger_carriage
    super
  end
end
