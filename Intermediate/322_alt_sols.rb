def palindrome num
  num.to_s == num.to_s.reverse ? true : false
end

def largest(n)
  answer = 0
  products = []
  top = (9.to_s * (n+4)).to_i
  top.downto(1) do |x|
    products << x if palindrome(x)
    break if x < (8.to_s * (n+4)).to_i
  end
  products
end

def largest(n)
  start = Time.now
  range = (9.to_s + '0'*(n-1)).to_i..(9.to_s * n).to_i
  answer = 0
  max = range.end
  range.each do |x|
    max.downto(x) do |y|
      if (x * y) > answer && palindrome(x * y)
        answer = (x * y)
        break
      end
    end
  end
  puts Time.now - start
  answer
end

def largest(n)
  start = Time.now
  beg = (9.to_s + '0'*(n-1)).to_i
  finish = (9.to_s * n).to_i
  answer = 0
  (beg..finish).each do |x|
    finish.downto(x) do |y|
      if (x * y) > answer && palindrome(x * y)
        answer = (x * y)
        break
      end
    end
  end
  puts Time.now - start
  answer
end

def largest(n)
  start = Time.now
=begin
  beg = (9.to_s + '0'*(n-1)).to_i
  finish = (9.to_s * n).to_i
  products = []
  (beg..finish).each {|a| (beg..finish).each { |b| products << (a * b) if palindrome(a * b) }}
=end
  products = []
  ((9.to_s + '5'*(n-1)).to_i..(9.to_s * n).to_i).each do |a|
    ((9.to_s + '5'*(n-1)).to_i..(9.to_s * n).to_i).each do
      |b| products << (a * b) if palindrome(a * b)
    end
  end
  puts Time.now - start
  products.sort.last
end
=begin
  case n.to_i
  when 2 then (90..99).each {|x| (90..99).each { |y| products<<(x*y) if palindrome(x*y) }}
  when 3 then (900..999).each {|x| (900..999).each {|y| products<<(x*y) if palindrome(x*y)}}
  when 4 then (9000..9999).each {|x| (9000..9999).each {|y| products<<(x*y) if palindrome(x*y)}}
  when 5 then (90000..99999).each {|x| (90000..99999).each {|y| products<<(x*y) if palindrome(x*y)}}
  when 6 then (900000..999999).each {|x| (900000..999999).each {|y| products<<(x*y) if palindrome(x*y)}}
  when 7 then (9000000..9999999).each {|x| (9000000..9999999).each {|y| products<<(x*y) if palindrome(x*y)}}
  when 8 then (90000000..99999999).each {|x| (90000000..99999999).each {|y| products<<(x*y) if palindrome(x*y)}}
  when 9 then (900000000..999999999).each {|x| (900000000..999999999).each {|y| products<<(x*y) if palindrome(x*y)}}
  end
  puts Time.now - start
  products.sort.last
end
=end

def largest(low=1,n)
  start = Time.now
  best = { product: false }
  (n-1).downto(low) do |start1|
    start2 = best[:product] ? (best[:product]/start1.to_f).ceil : start1+1
    break if start2 > n
    found2 = n.downto(start2).find { |j| palindrome(start1*j) }
    best = { product: start1*found2, v1: start1, v2: found2 } if found2
  end
  puts Time.now - start
  best
end