require 'benchmark'


Benchmark.bm do |x|
  x.report('2**1234: ') { puts (2**1234).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('11**4000: ') { puts (11**4000).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('50**3000: ') { puts (50**3000).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**12345: ') { puts (12345**12345).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**123456: ') { puts (12345**123456).to_s.split(//).map(&:to_i).inject(:+) }
  x.report('12345**1234567: ') { puts (12345**1234567).to_s.split(//).map(&:to_i).inject(:+) }
end