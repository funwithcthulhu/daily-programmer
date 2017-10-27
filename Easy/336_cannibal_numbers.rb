# Daily Programmer - Easy - #336
# Example input:  7 2     
#                 21 9 5 8 10 1 3
#                 10 15 
#
# Output: 4 2
# below breaks current code. TODO: make fix
# 3 3 3 2 2 2 1 1 1
# 4

def cannibalize(array, sz)
  array = array.sort.reverse
  cannibals = []
  array.each { |v| cannibals << v if v >= sz }
  cannibals.size.times { array.shift }
  storage = []
  until array.empty?
    if !storage.empty? && storage.first > array.first
      candidate = storage.shift
    else
      candidate = array.shift
    end
    until array.empty? || candidate >= sz
      #temp = array.pop
      temp = array.shift
      candidate += 1 if candidate != temp
      if candidate == temp
        storage << temp
      end
      cannibals << candidate if candidate >= sz
    end
  end
  cannibals.size
end

def input_loop
  puts 'press return on empty line to exit'
  puts 'separate input with spaces: '
  loop do
    print 'numbers > '
    input = gets.chomp.split(/\s+/).map(&:to_i)
    break if input.empty?
    print 'queries > '
    queries = gets.chomp.split(/\s+/).map(&:to_i)
    break if input.empty?
    queries.each do |query|
      puts "solution for query #{query}: #{cannibalize(input, query)}"
    end
  end
end

input_loop
