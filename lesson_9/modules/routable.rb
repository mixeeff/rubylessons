# frozen_string_literal: true

module Routable
  def to_route(route)
    @route = route
    @route.stations[0].accept_train(self)
    @current_station_num = 0
    route
  end

  def on_route?
    @route
  end

  def go_next_station
    return unless @route
    return unless next_station

    current_station.send_train(self)
    next_station.accept_train(self)
    @current_station_num += 1
    current_station
  end

  def go_previous_station
    return unless @route
    return unless previous_station

    current_station.send_train(self)
    previous_station.accept_train(self)
    @current_station_num -= 1
    current_station
  end

  def current_station
    return unless @route

    @route.stations[@current_station_num]
  end

  private

  def next_station
    return unless @route

    @route.stations[@current_station_num + 1]
  end

  def previous_station
    return unless @route
    return if @current_station_num.zero?

    @route.stations[@current_station_num - 1]
  end
end
