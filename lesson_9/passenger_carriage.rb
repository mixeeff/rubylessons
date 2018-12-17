# frozen_string_literal: true

require_relative('modules/manufacturer')
require_relative('meta_modules/validation')

class PassengerCarriage < Carriage
  include Validation

  validate :number, :format, NUMBER_FORMAT
  validate :space, :presence
  validate :space, :type, Integer
  validate :owner, :type, Train

  def reserve_space
    super(1)
  end

  def to_s
    result = "Passenger carriage №#{number}"
    result << ", made by #{manufacturer}" unless manufacturer.empty?
    result << ". #{@space} seats, #{free_space} free"
    result
  end
end
