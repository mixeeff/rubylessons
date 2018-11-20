require_relative('station.rb')
require_relative('route.rb')
require_relative('train.rb')

def print_trains(station, type)
    trains = station.trains_by_type(type)
    unless trains
      puts "There are no trains on station #{station.name}"
      return
    end
    puts "#{type.capitalize} trains on station #{station.name}:"
    trains.each do |train|
      if train.type == Train::PASSENGER
        output_str = "Passenger "
      else
        output_str = "Freight "
      end
      output_str += "train number #{train.number} with "
      output_str += "#{train.carriages_count} cars"
      puts output_str
    end
end

moscow = Station.new('Moscow')
piter = Station.new('St.Petersburg')
bologoe = Station.new('Bologoe')
tver = Station.new('Tver')
klin = Station.new('Klin')

route1 = Route.new(moscow, piter)
route1.insert_station(klin)
route1.insert_station(tver)
route1.insert_station(bologoe)

route1.report

express_route = Route.new(moscow, piter)
express_route.insert_station(bologoe)
express_route.insert_station(tver)
express_route.delete_station(tver)

express_route.report

sapsan = Train.new('001', Train::PASSENGER, 10)
cargo = Train.new('885', Train::FREIGHT, 35)

sapsan.speed_up(200)
print "Sapsan speed is "
puts sapsan.speed_down(50)
print "Cargo speed is "
puts cargo.speed_up(75)
print "Cargo carriages count is "
puts cargo.add_carriage
cargo.speed_down(75)
print "Cargo carriages count is "
puts cargo.remove_carriage

sapsan.set_route(express_route)
cargo.set_route(route1)

print "Sapsan. The next station is "
puts sapsan.next_station.name

sapsan.go_next_station
cargo.go_next_station
cargo.go_next_station
cargo.go_previous_station
print "Cargo. The previous station is "
puts cargo.previous_station.name

sapsan.go_next_station

print_trains(piter,Train::PASSENGER)
print_trains(klin, Train::FREIGHT)
