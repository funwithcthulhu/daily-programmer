# frozen_string_literal: true

# Daily Programmer - Easy - #353 - Closest String
# See https://redd.it/826coe

def closest(n)
  hamming = ->(a, b) { a.chars.zip(b.chars).count { |n1, n2| n1 != n2 } }
  strings = [].tap { |x| n.times { x << gets.chomp } }
  strings.min_by { |a| strings.reduce(0) { |sum, y| sum + hamming[a, y] } }
end
