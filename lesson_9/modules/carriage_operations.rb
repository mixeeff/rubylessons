# frozen_string_literal: true

require_relative('constants')

module CarriageOperations
  include Constants

  def new_pass_carriage
    begin
      seats = ask_user('Enter number of seats').to_i
      num = ask_user('Enter carriage number (starts with A-Z)')
      carriage = PassengerCarriage.new(num, seats)
    rescue RuntimeError => e
      puts e.message
      retry
    end

    @my_railway.passenger_carriages << carriage
    carriage
  end

  def new_cargo_carriage
    begin
      volume = ask_user('Enter volume')
      num = ask_user('Enter carriage number')
      carriage = CargoCarriage.new(num, volume)
    rescue RuntimeError => e
      puts e.message
      retry
    end

    @my_railway.cargo_carriages << carriage
    carriage
  end

  def create_carriage
    type = choose_from_list(TRAIN_TYPES, 'type of the carriage')
    return unless type

    carriage = if type == TRAIN_TYPES[0]
                 new_pass_carriage
               else
                 new_cargo_carriage
               end
    puts "#{carriage} created."
  end
end
