# frozen_string_literal: true

require_relative('modules/manufacturer')
require_relative('modules/instance_counter')
require_relative('meta_modules/validation')

class Carriage
  include Validation

  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[A-Z]+\d+$/.freeze

  attr_reader :space, :free_space, :number, :owner

  validate :number, :format, NUMBER_FORMAT
  validate :space, :presence
  validate :space, :type, Integer
  validate :owner, :type, Train

  def initialize(number, space)
    @number = number
    @space = space
    @free_space = space
    @manufacturer = ''
    validate!
    register_instance
  end

  def reserve_space(space)
    raise NOT_ENOUGH_SPACE if space > @free_space

    @free_space -= space
  end

  def reserved_space
    @space - @free_space
  end

  def to_s
    result = "Carriage №#{number}"
    result << ", made by #{manufacturer}" if manufacturer
    result
  end

  def owner=(owner)
    raise OWNER_ERROR unless (owner.is_a? Train) || owner.nil?

    @owner = owner
    validate!
  end
end
