letters = ('A'..'Z').to_a
vowels = %w[A E I O U]
vowels_hash ={}
letters.each.with_index(1) do |letter,index| 
  vowels_hash[letter] = index if vowels.include?(letter)
end
puts vowels_hash
