require 'benchmark'

def pal(n)
  fin = ('1' + '0' * (n - 1)).to_i
  start = half = fin * 10
  highest = 0
  while highest.zero?
    half -= 1
    full = (half.to_s + half.to_s.reverse).to_i
    (start - 1).downto(fin) do |i|
      break if full / i >= start
      highest = full if (full % i).zero?
    end
  end
  puts highest
end

Benchmark.bm do |x|
  x.report('pal(3): ') { pal(3) }
  x.report('pal(4): ') { pal(4) }
  x.report('pal(5): ') { pal(5) }
  x.report('pal(6): ') { pal(6) }
  x.report('pal(7): ') { pal(7) }
  x.report('pal(8): ') { pal(8) }
  x.report('pal(9): ') { pal(9) }
  x.report('pal(10): ') { pal(10) }
  x.report('pal(11): ') { pal(11) }
end
