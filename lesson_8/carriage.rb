require_relative('manufacturer')
require_relative('instance_counter')

class Carriage
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[A-Z]+\d+$/.freeze
  OWNER_ERROR = 'Owner must be a Train or Nil'.freeze
  WRONG_NUMBER_ERROR = 'Number must be String'.freeze
  EMRTY_NUMBER_ERROR = 'Number can\'t be empty'.freeze
  NUMBER_FORMAT_ERROR = 'Wrong number format'.freeze
  WRONG_SPACE = 'Carrige\'s space must be more than zero'.freeze
  NOT_ENOUGH_SPACE = 'There\'s not enough free space in carriage'.freeze

  attr_reader :space, :free_space, :number, :owner

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
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise WRONG_NUMBER_ERROR unless number.is_a? String
    raise EMRTY_NUMBER_ERROR if number.size.zero?
    raise NUMBER_FORMAT_ERROR if number !~ NUMBER_FORMAT
    raise WRONG_SPACE if space <= 0
  end
end
