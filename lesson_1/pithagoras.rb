puts "Введите длины сторон треугольника:"
sides = []
print "A = "
sides[0] = gets.to_f
print "B = "
sides[1] = gets.to_f
print "C = "
sides[2] = gets.to_f
sides.sort!
#определяем тип треугольника
valid_triangle = sides[2] < sides[1] + sides[2]
right_triangle = (sides[2]**2).round(5) == sides[0]**2 + sides[1]**2
equilateral_triangle = sides[0] == sides[1] && sides[1] == sides[2]
isosceles_triangle = sides[0] == sides[1]
#вывод результатов
if !valid_triangle
  puts "Это не треугольник!"
elsif right_triangle && isosceles_triangle
  puts "Треугольник прямоугольный равнобедренный"
elsif right_triangle
  puts "Треугольник прямоугольный"
elsif equilateral_triangle
  puts "Треугольник равносторонний"
else
  puts "Треугольник не прямоугольный, не равносторонний"
end
