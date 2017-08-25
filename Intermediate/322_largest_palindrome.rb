def palindrome num
  num.to_s == num.to_s.reverse ? true : false
end

def largest(n)
  start = Time.now
  case n.to_i
  when 2 then array = (10..99).to_a
  when 3 then array = (100..999).to_a
  when 4 then array = (1000..9999).to_a
  when 5 then array = (10000..99999).to_a
  when 6 then array = (100000..999999).to_a
  when 7 then array = (1000000..9999999).to_a
  when 8 then array = (10000000..99999999).to_a
  when 9 then array = (100000000..999999999).to_a
  end
  products = [0]
  array.reverse.each {|a| array.reverse.each { |b| products.push(a*b) if palindrome(a*b) && a*b > products.sort.last}}
  puts Time.now - start
  products.sort.last 
end
