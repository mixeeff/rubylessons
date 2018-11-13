letters = ("A".."Z").to_a
vowels = ["A", "E", "I", "O", "U"]
vowels_hash ={}
letters.each_index do |index|
  letter = letters[index]
  if vowels.include?(letter)
    vowels_hash[letter] = index + 1
  end
end
puts vowels_hash
