require_relative('manufacturer')
class Carriage
  include Manufacturer
  include InstanceCounter
  attr_reader :number
  attr_reader :owner

  NUMBER_FORMAT = /[A-Z]+\d+/
  
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
    raise "Owner must be a Train" unless owner.is_a? Train
    self.owner = owner
  end


  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Number can't be nil" if number.nil?
    raise "Number can't be empty" if number.size.zero?
    raise "Number can contains 1 or more capitalized latin letters and 1 or more digits" if number !~ NUMBER_FORMAT
  end
end
