class CargoTrain < Train
  def to_s
    result = "Cargo train №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result += ", #{@carriages.size} carriage(s)" if has_carriages?
    result
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
