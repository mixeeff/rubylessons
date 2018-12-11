class PassengerTrain < Train
  @instances_list = {}

  def to_s
    result = "Passenger train №#{number}"
    result << ", made by #{manufacturer}" unless manufacturer.empty?
    result << ", #{@carriages.size} carriage(s)" if carriages?
    result
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
