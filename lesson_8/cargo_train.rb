class CargoTrain < Train
  @instances_list = {}

  def to_s
    result = "Cargo train №#{number}"
    result << ", made by #{manufacturer}" unless manufacturer.empty?
    result << ", #{@carriages.size} carriage(s)" if carriages?
    result
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
