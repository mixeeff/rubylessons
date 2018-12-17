# frozen_string_literal: true

require_relative('meta_modules/validation')

class CargoTrain < Train
  include Validation

  @instances_list = {}

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

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
