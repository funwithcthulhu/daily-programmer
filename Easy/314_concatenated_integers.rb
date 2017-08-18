def concatenate_integers
  puts 'Input integers separated by a space'
  puts 'Hit return when finished'
  print '> '
  input = gets.split(' ')
  output = input.permutation(input.size).to_a
  output.map! { |array| array.join('') }.map!(&:to_i).sort!
  puts "#{output.min} #{output.max }"
end 

concatenate_integers