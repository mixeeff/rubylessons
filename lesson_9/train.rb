# frozen_string_literal: true

require_relative('meta_modules/accessors')
require_relative('meta_modules/validation')
require_relative('modules/manufacturer')
require_relative('modules/instance_counter')
require_relative('modules/routable')

class Train
  extend Acсessors
  include Validation

  include Manufacturer
  include InstanceCounter
  include Routable

  NUMBER_FORMAT = /^[0-9a-z]{3}-?[0-9a-z]{2}$/i.freeze

  @instances_list = {}

  strong_attr_accessor :number, String
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT
  attr_reader :speed, :carriages

  class << self
    attr_accessor :instances_list
  end

  def self.find(number)
    instances_list[number]
  end

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
    @speed = 0 if @speed.negative?
    @speed
  end

  def carriages?
    !@carriages.empty?
  end

  def add_carriage(carriage)
    return unless attachable_carriage?(carriage)
    return unless speed.zero?

    carriage.owner&.remove_carriage(carriage)
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
end
