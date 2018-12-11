require_relative('station')
require_relative('route')
require_relative('train')
require_relative('passenger_train')
require_relative('cargo_train')
require_relative('carriage')
require_relative('passenger_carriage')
require_relative('cargo_carriage')
require_relative('railway_state')
require_relative('test_railway')
require_relative('user_interface')
require_relative('station_operations')
require_relative('train_operations')
require_relative('carriage_operations')
require_relative('route_operations')
require_relative('constants')

class Main
  include UserInterface
  include TestRailway
  include StationOperations
  include TrainOperations
  include CarriageOperations
  include RouteOperations
  include Constants

  def initialize
    @my_railway = RailwayState.new
  end

  def choose_route
    choose_from_list(@my_railway.routes, 'route')
  end

  def choose_train(type = nil)
    train_list =
      if type == TRAIN_TYPES[0]
        @my_railway.trains.select { |train| train.is_a? PassengerTrain }
      elsif type == TRAIN_TYPES[1]
        @my_railway.trains.select { |train| train.is_a? CargoTrain }
      else
        @my_railway.trains
      end
    choose_from_list(train_list, 'train')
  end

  # Testing method

  def test_railway
    test_stations
    test_trains
    test_carriages
    test_routes
  end

  def run
    loop do
      user_choise = menu
      break unless user_choise

      send user_choise
      puts ''
    end
  end
end

my_app = Main.new
my_app.run
