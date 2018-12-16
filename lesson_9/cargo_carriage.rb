# frozen_string_literal: true

require_relative('modules/manufacturer')
require_relative('meta_modules/validation')

class CargoCarriage < Carriage
  extend Validation

  validate :number, :format, NUMBER_FORMAT
  validate :space, :presence
  validate :space, :type, Integer
  validate :owner, :type, Train

  def to_s
    result = "Cargo carriage №#{number}"
    result << ", made by #{manufacturer}" unless manufacturer.empty?
    result << ". #{@space} sq.meters, #{free_space} sq.meters free"
    result
  end
end
