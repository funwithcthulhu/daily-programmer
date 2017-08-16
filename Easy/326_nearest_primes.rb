require 'prime'

def nearest_primes num
  beginning_time = Time.now
  puts num.to_s 'is prime.' if num.prime?
  lower = num
  higher = num
  loop { lower.prime? ? break : lower -= 1 }
  loop { higher.prime? ? break : higher += 1 }
  puts "#{lower} < #{num} < #{higher}" if num.prime? == false
  end_time = Time.now
  puts 'Total time req: ' + (end_time - beginning_time).to_s
end
