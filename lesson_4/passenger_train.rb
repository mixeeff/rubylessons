class PassengerTrain < Train
  def to_s
    "Passenger train №#{number}"
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
