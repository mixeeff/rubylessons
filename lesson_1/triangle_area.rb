print "Введите длину основания треугольника: "
length = gets.chomp.to_i
print "Введите высоту треугольника: "
height = gets.chomp.to_i
area = 0.5 * length * height
puts "Площадь треугольника = #{area.round(1)}"