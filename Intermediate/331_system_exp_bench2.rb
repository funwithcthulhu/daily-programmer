require 'benchmark'


Benchmark.bm do |x|
  x.report('2**1234: ') { (2**1234) }
  x.report('11**4000: ') { (11**4000) }
  x.report('50**3000: ') { (50**3000) }
  x.report('12345**12345: ') { (12345**12345) }
  x.report('12345**123456: ') { (12345**123456) }
  x.report('12345**1234567: ') { (12345**1234567) }
end

def power(n, exponent)
  prod = 1
  while exponent > 0
    prod *= n if (exponent & 1) != 0
    n *= n
    exponent >>= 1
  end
  prod
end
  

Benchmark.bm do |x|
  x.report('2**1234: ') { power(2, 1234) }
  x.report('11**4000: ') { power(11, 4000) }
  x.report('50**3000: ') { power(50, 3000) }
  x.report('12345**12345: ') { power(12345, 12345) }
  x.report('12345**123456: ') { power(12345, 123456) }
  x.report('12345**1234567: ') { power(12345, 1234567) }
  x.report('12345**12345678: ') { power(12345, 12345678) }
  x.report('12345**123456789: ') { power(12345, 123456789) }
  x.report('12345**1234567899: ') { power(12345, 1234567899) }
end