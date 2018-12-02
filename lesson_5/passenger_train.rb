class PassengerTrain < Train
  set_instance_counter

  def to_s
    result = "Passenger train №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
