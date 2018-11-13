
goods = {}
good_sum = Hash.new(0)
total = 0

loop do
  print "Название товара: "
  name = gets.chomp
  break if name == "стоп"
  if goods[name]
    puts "Такой товар уже есть"
    next
  end
  print "Цена за единицу: "
  price = gets.to_f
  print "Количество: "
  quantity = gets.to_f
  goods[name] = { price: price, quantity: quantity }
end

puts goods

goods.each { |good, value| good_sum[good] = value[:price] * value[:quantity] }
good_sum.each_value { |val| total+=val }

puts "Сумма по товарам:"
good_sum.each { |good, sum| puts "#{good} - #{sum.round(2)}" }
puts "Общая сумма = #{total.round(2)}"
