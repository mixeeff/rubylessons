require_relative('manufacturer')
class Carriage
  include Manufacturer
  include InstanceCounter
  attr_reader :number
  attr_reader :owner

  NUMBER_FORMAT = /^[A-Z]+\d+$/
  OWNER_ERROR = 'Owner must be a Train or Nil'
  WRONG_NUMBER_ERROR = 'Number must be String'
  EMRTY_NUMBER_ERROR = 'Number can\'t be empty'
  NUMBER_FORMAT_ERROR = 'Wrong number format'
  
  def initialize(number)
    @number = number
    validate!
    register_instance
  end

  def to_s
    result = "Carriage №#{number}"
    result += ", made by #{manufacturer}" if manufacturer
    result
  end

  def owner=(owner)
    raise OWNER_ERROR unless (owner.is_a? Train) || owner.nil?
    @owner = owner
  end


  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise WRONG_NUMBER_ERROR unless number.is_a? String
    raise EMRTY_NUMBER_ERROR if number.size.zero?
    raise NUMBER_FORMAT_ERROR if number !~ NUMBER_FORMAT
  end
end
