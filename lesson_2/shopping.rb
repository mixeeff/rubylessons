goods = {}
total = 0

loop do
  print 'Название товара: '
  name = gets.chomp.downcase
  break if name == 'стоп'
  if goods[name]
    puts 'Такой товар уже есть'
    next
  end
  print 'Цена за единицу: '
  price = gets.to_f
  print 'Количество: '
  quantity = gets.to_f
  goods[name] = { price: price, quantity: quantity }
end

puts goods
puts 'Сумма по товарам:'
goods.each do |good, value| 
  good_sum = value[:price] * value[:quantity]
  puts "#{good} - #{good_sum}"
  total += good_sum
end

puts "Общая сумма = #{total.round(2)}"
