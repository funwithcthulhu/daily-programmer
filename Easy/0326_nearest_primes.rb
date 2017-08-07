require 'prime'

def nearest_primes num
  beginning_time = Time.now
  puts "#{num} is prime." if num.prime?
  lower = num
  higher = num
  loop do
    lower.prime? ? break : lower-=1
  end
  loop do
    higher.prime? ? break : higher+=1
  end
  puts "#{lower} < #{num} < #{higher}" if num.prime? == false
  end_time = Time.now
  puts "Total time req: #{end_time-beginning_time}"
end
