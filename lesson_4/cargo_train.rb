class Cargo_train < Train
  def initialize(number)
    super
    @type = Railway::TRAIN_TYPES[1]
  end

  def to_s
    'Cargo train №' + number
  end
  
  def add_carriage(carriage)
    return unless carriage.class == Cargo_carriage
    super
  end
  
  def remove_carriage(carriage)
    return unless carriage.class == Cargo_carriage
    super
  end

end
