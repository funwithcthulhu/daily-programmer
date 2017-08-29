require 'benchmark'

def lucky(max)
  array = 1.step(max, 2).to_a.unshift(0)
  ind = 2
  until array[ind] == array.last
    val = array[ind]
    array.each_index { |i| array[i] = nil if (i % val).zero? && array[i] > val }
    ind += 1
    array.compact!
  end
  block_given? ? (yield array) : array
end

def nearest(num)
  puts lucky(num).include?(num) ? "#{num} is Lucky" : find_near(num)
end

def find_near(num)
  higher = num + 1
  lower = num - 1
  loop do
    lucky(num * 2).include?(higher) ? break : higher += 1
  end
  loop do
    lucky(num * 2).include?(lower) ? break : lower -= 1
  end
  "#{lower} < #{num} < #{higher}"
end

Benchmark.bm do |x|
  x.report('lucky(5000): ') { lucky(5000) }
  x.report('lucky(10_000): ') { lucky(10_000) }
  x.report('lucky(1_000_000): ') { lucky(1_000_000) }
  x.report('lucky(10_000_000): ') { lucky(10_000_000) }
end
