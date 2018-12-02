class CargoTrain < Train
  set_instance_counter

  def to_s
    result = "Cargo train №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
