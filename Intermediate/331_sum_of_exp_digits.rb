require 'benchmark'

def power(n, exponent)
  prod = 1
  while exponent > 0
    prod *= n if (exponent & 1) != 0
    n *= n
    exponent >>= 1
  end
  prod
end

#puts power(n, exponent).to_s.split(//).map(&:to_i).inject(:+)

Benchmark.bm do |x|
  x.report('2**1234: ') { puts power(2, 1234).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('11**4000: ') { puts power(11, 4000).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('50**3000: ') { puts power(50, 3000).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**12345: ') { puts power(12345, 12345).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**123456: ') { puts power(12345, 123456).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**1234567: ') { puts power(12345, 1234567).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**12345678: ') { puts power(12345, 12345678).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**123456789: ') { puts power(12345, 123456789).to_s.split(//).map(&:to_i).inject(:+) }
end