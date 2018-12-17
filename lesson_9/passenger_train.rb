# frozen_string_literal: true

require_relative('meta_modules/validation')

class PassengerTrain < Train
  include Validation

  @instances_list = {}

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    self.number = number
    @carriages = []
    @speed = 0
    @manufacturer = ''
    validate!
    register_instance
    self.class.instances_list[number] = self
  end

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
