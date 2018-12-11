require_relative('manufacturer')

class CargoCarriage < Carriage
  def to_s
    result = "Cargo carriage №#{number}"
    result << ", made by #{manufacturer}" unless manufacturer.empty?
    result << ". #{@space} sq.meters, #{free_space} sq.meters free"
    result
  end
end
