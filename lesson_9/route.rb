# frozen_string_literal: true

require_relative('modules/instance_counter')
require_relative('meta_modules/validation')

class Route
  extend Validation
  include InstanceCounter

  SAME_STATIONS_ERROR = 'Start and End stations must be different'

  attr_reader :stations
  validate :start_station, :presence
  validate :end_station, :presence
  validate :start_station, :type, Station
  validate :end_station, :type, Station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    validate!
    @stations = [start_station, end_station]
    register_instance
    @number = Route.instances
  end

  def to_s
    "Route №#{@number} #{@start_station.name} - #{@end_station.name}"
  end

  def add_station(station)
    @stations.insert(-2, station)
    @stations
  end

  def delete_station(station)
    @stations.delete(station)
    if @stations.size == 2
      @start_station = @stations[0]
      @end_station = @stations[1]
    end
    @stations
  end

  def report
    puts "Stations on route #{self}:"
    @stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station.name}"
    end
  end
end
