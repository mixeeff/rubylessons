# frozen_string_literal: true

require_relative('station')
require_relative('train')
require_relative('passenger_train')
require_relative('cargo_train')
require_relative('carriage')
require_relative('passenger_carriage')
require_relative('cargo_carriage')
require_relative('route')
require_relative('railway_state')

require_relative('modules/user_interface')
require_relative('modules/station_operations')
require_relative('modules/train_operations')
require_relative('modules/carriage_operations')
require_relative('modules/route_operations')

class Main
  include UserInterface
  include StationOperations
  include TrainOperations
  include CarriageOperations
  include RouteOperations

  def initialize
    @my_railway = RailwayState.new
  end

  def run
    loop do
      user_choise = menu
      break unless user_choise

      selected_method = method_name(user_choise)
      send selected_method
      puts ''
    end
  end
end

my_app = Main.new
my_app.run
