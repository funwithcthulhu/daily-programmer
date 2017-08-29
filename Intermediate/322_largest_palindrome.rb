require 'benchmark'

def pal(n, &block)
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
  yield highest
end

pal(ARGV[0].to_i) { |n| puts n }

Benchmark.bm do |x|
  x.report('pal(3): ') { pal(3) { |n| puts n } }
  x.report('pal(4): ') { pal(4) { |n| puts n } }
  x.report('pal(5): ') { pal(5) { |n| puts n } }
  x.report('pal(6): ') { pal(6) { |n| puts n } }
  x.report('pal(7): ') { pal(7) { |n| puts n } }
  x.report('pal(8): ') { pal(8) { |n| puts n } }
end
