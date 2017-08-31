def recursive(n, m, p)
  p.zero? ? (return n) : recursive((next_val(n, m)), m, p - 1)
end

def next_val(n, m)
  n - (((n * n) - m) / (2 * n))
end

def mysqrt(n,p=100)
  raise Exception.new('Undefined') unless n > 0 
  recursive(n, n, p)
end