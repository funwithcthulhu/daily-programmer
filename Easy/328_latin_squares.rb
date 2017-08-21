def latin_square?
  dups = []
  puts 'Enter length of array'
  print '> '
  length = gets.chomp.to_i
  puts 'Enter n x n numbers, each separated by a space'
  print '> '
  numbers = gets.chomp
  matrix = numbers.split(' ').map!(&:to_i)
  rows = matrix.length / length
  rows.times do
    temp = matrix.slice!(0...length)
    matrix << temp
  end
  matrix.each do |col|
    dups = col.select { |num| col.count(num) > 1 }
  end
  matrix.transpose.each do |col|
    dups = col.select { |num| col.count(num) > 1 }
  end
  dups.empty? ? true : false
end


