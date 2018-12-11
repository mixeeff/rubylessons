require_relative('manufacturer')
require_relative('instance_counter')
require_relative('routable')

class Train
  include Manufacturer
  include InstanceCounter
  include Routable

  NUMBER_FORMAT = /^[0-9a-z]{3}-?[0-9a-z]{2}$/i.freeze
  WRONG_NUMBER_ERROR = 'Number must be String'.freeze
  EMRTY_NUMBER_ERROR = 'Number can\'t be empty'.freeze
  NUMBER_FORMAT_ERROR = 'Wrong number format'.freeze

  @instances_list = {}

  attr_reader :number, :speed, :carriages

  class << self
    attr_accessor :instances_list
  end

  def self.find(number)
    instances_list[number]
  end

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @manufacturer = ''
    validate!
    register_instance
    self.class.instances_list[number] = self
  end

  def to_s
    result = "Train №#{number}"
    result << ", made by #{manufacturer}" unless manufacturer.empty?
    result << ", #{@carriages.size} carriages" if carriages?
    result
  end

  def speed_up(speed = 1)
    @speed += speed
  end

  def speed_down(speed = 1)
    @speed -= speed
    @speed = 0 if @speed < 0
    @speed
  end

  def carriages?
    !@carriages.empty?
  end

  def add_carriage(carriage)
    return unless attachable_carriage?(carriage)
    return unless speed.zero?

    carriage.owner.remove_carriage(carriage) if carriage.owner
    @carriages << carriage
    carriage.owner = self
  end

  def remove_carriage(carriage)
    return unless attachable_carriage?(carriage)
    return unless speed.zero?

    @carriages.delete(carriage)
    carriage.owner = nil
  end

  def each_carriage
    return unless block_given?

    @carriages.each { |carriage| yield(carriage) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise WRONG_NUMBER_ERROR unless number.is_a?(String)
    raise EMRTY_NUMBER_ERROR if number.strip.empty?
    raise NUMBER_FORMAT_ERROR if number !~ NUMBER_FORMAT
  end
end
