# frozen_string_literal: true

class RailwayState
  TRAIN_TYPES = %w[Passenger Cargo].freeze

  attr_accessor :stations, :trains, :routes
  attr_accessor :passenger_carriages, :cargo_carriages

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @passenger_carriages = []
    @cargo_carriages = []
  end

  def stations?
    !@stations.empty?
  end

  def add_station(station)
    @stations << station
    station
  end

  def trains?
    !@trains.empty?
  end

  def add_train(train)
    @trains << train
    train
  end

  def routes?
    !@routes.empty?
  end

  def add_route(route)
    @routes << route
    route
  end

  def add_carriage(carriage)
    if carriage.is_a? PassengerCarriage
      @passenger_carriages << carriage
    elsif carriage.is_a? CargoCarriage
      @cargo_carriages << carriage
    end
  end
end
