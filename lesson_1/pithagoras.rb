puts "Введите длины сторон треугольника:"
sides = []
print "A = "
sides[0] = gets.chomp.to_f
print "B = "
sides[1] = gets.chomp.to_f
print "C = "
sides[2] = gets.chomp.to_f
sides.sort!
if sides[0]+sides[1] < sides[2]
	puts "Это не треугольник!"
elsif sides[0] == sides[1] && sides[1] == sides[2]
 puts "Треугольник равносторонний"
else
 if sides[2]**2 == sides[0]**2 + sides[1]**2
 	puts "Треугольник прямоугольный"
 else
 	puts "Треугольник НЕ прямоугольный"
 end
 puts "Треугольник равнобедренный" if sides[0] == sides[1]
end 