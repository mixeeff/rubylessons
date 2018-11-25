class CargoTrain < Train
  def to_s
    "Cargo train #{number}"
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
