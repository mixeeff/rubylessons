# frozen_string_literal: true

require_relative('modules/instance_counter')
require_relative('meta_modules/accessors')
require_relative('meta_modules/validation')

class Station
  extend Acсessors
  extend Validation
  include InstanceCounter

  @instances_list = {}

  attr_accessor_with_history :name
  validate :name, :presence
  validate :name, :type, String
  attr_reader :trains

  class << self
    attr_accessor :instances_list
  end

  def self.all
    instances_list.values
  end

  def initialize(name)
    self.name = name
    @trains = []
    validate!
    register_instance
    self.class.instances_list[name] = self
  end

  def to_s
    name
  end

  def accept_train(train)
    @trains << train unless @trains.include?(train)
  end

  def send_train(train)
    @trains.delete(train)
    @trains
  end

  def trains?
    !@trains.empty?
  end

  def each_train
    return unless block_given?

    @trains.each { |train| yield(train) }
  end
end
