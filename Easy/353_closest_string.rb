# frozen_string_literal: true

# Daily Programmer - Easy - #353 - Closest String
# See https://redd.it/826coe

def closest(n, strings)
  hamming = ->(a, b) { a.chars.zip(b.chars).count { |n1, n2| n1 != n2 } }
  strings.min_by { |a| strings.reduce(0) { |sum, y| sum + hamming[a, y] } }
end

if __FILE__ == $0
  print 'n: '
  n = gets.chomp.to_i
  strings = [].tap { |x| n.times { x << gets.chomp } }
  puts 'closest string: ' + closest(n, strings)
end

# one line version
# [].tap { |x| n.times { x << gets.chomp }; return x.min_by { |a| x.reduce(0) { |sum, y| sum + a.chars.zip(y.chars).count { |n1, n2| n1 != n2 } } } }

