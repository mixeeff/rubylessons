class PassengerTrain < Train
  def to_s
    result = "Passenger train №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result += ", #{@carriages.size} carriage(s)" if has_carriages?
    result
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
