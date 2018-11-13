fibonacci = [0, 1]
i = 2
loop do
  next_fibonacci = fibonacci[i-1] + fibonacci[i-2]
  break if next_fibonacci > 100
  fibonacci << next_fibonacci
  i += 1
end
puts fibonacci   
