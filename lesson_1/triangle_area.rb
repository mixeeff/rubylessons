print "Введите длину основания треугольника: "
length = gets.to_f
print "Введите высоту треугольника: "
height = gets.to_f
area = 0.5 * length * height
puts "Площадь треугольника = #{area.round(3)}"
