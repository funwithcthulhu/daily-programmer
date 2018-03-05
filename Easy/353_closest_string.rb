# Daily Programmer - Easy - #353 - Closest String
# See https://redd.it/826coe

# frozen_string_literal: true

def closest(n)
  hamming = ->(a, b) { a.chars.zip(b.chars).count { |n1, n2| n1 != n2 } }
  best_string, best_dist = nil, Float::INFINITY
  strings = [].tap { |x| n.times { x << gets.chomp } }
  strings.each do |a|
    dist_sum = strings.inject(0) { |sum, y| sum + hamming[a, y] }
    if dist_sum < best_dist
      best_string = a
      best_dist = dist_sum
    end
  end
  best_string
end
