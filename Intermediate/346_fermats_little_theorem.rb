# Daily Programmer Intermediate 346

# Description
# Most introductionary implementations for testing the primality
# of a number have a time complexity ofO(n**0.5).

# For large numbers this is not a feasible strategy, for example
# testing a 400 digit number.

# Fermat's little theorem states:

# If p is a prime number, then for any integer a, the number a**p − a
# is an integer multiple of p.

# This can also be stated as (a**p) % p = a

# If n is not prime, then, in general, most of the numbers a < n will not
# satisfy the above relation. This leads to the following algorithm for
# testing primality: Given a number n, pick a random number a < n and
# compute the remainder of a**n modulo n. If the result is not equal to a,
# then n is certainly not prime. If it is a, then chances are good that n is
# prime. Now pick another random number a and test it with the same method.
# If it also satisfies the equation, then we can be even more confident that
# n is prime. By trying more and more values of a, we can increase our
# confidence in the result. This algorithm is known as the Fermat test.

# If n passes the test for some random choice of a, the chances are better
# than even that n is prime. If n passes the test for two random choices of
# a, the chances are better than 3 out of 4 that n is prime. By running the
# test with more and more randomly chosen values of a we can make the
# probability of error as small as we like.

# Create a program to do Fermat's test on a number, given a required certainty.
# Let the power of the modulo guide you.

# Formal Inputs & Outputs

# Input description

# Each line a number to test, and the required certainty.

# Output description

# Return True or False

# Bonus

# There do exist numbers that fool the Fermat test: numbers n that
# are not prime and yet have the property that a**n is congruent to
# a modulo n for all integers a < n. Such numbers are extremely rare,
# so the Fermat test is quite reliable in practice. Numbers that fool
# the Fermat test are called Carmichael numbers, and little is known
# about them other than that they are extremely rare. There are 255
# Carmichael numbers below 100,000,000.

# There are variants of the Fermat test that cannot be fooled by these.
# Implement one.

# Challange
# 29497513910652490397 0.9
# 29497513910652490399 0.9
# 95647806479275528135733781266203904794419584591201 0.99
# 95647806479275528135733781266203904794419563064407 0.99
# 2367495770217142995264827948666809233066409497699870112003149352380375124855230064891220101264893169 0.999
# 2367495770217142995264827948666809233066409497699870112003149352380375124855230068487109373226251983 0.999

# Bonus Challange
# 2887 0.9
# 2821 0.9

require 'openssl'

# Solovay–Strassen primality test
def fermat(p, c)
  t = 0.0
  while 1 - (1 / 2**t) < c
    a = rand(2...p)
    j = jacobi(a, p)
    return false if j.zero? || a.to_bn.mod_exp(((p - 1)/2), p) != j % p
    t += 1
  end
  true
end

# Code for jacobi symbol adapted from
# (https://github.com/smllmn/baillie-psw/blob/master/jacobi_symbol.py)
def jacobi(a, n)
  if n == 1
    return 1
  elsif a.zero?
    return 0
  elsif a == 1
    return 1
  elsif a == 2
    if [3, 5].include?(n % 8)
      return -1
    elsif [1, 7].include?(n % 8)
      return 1
    end
  elsif a < 0
    return (-1)**((n - 1) / 2) * jacobi(-1 * a, n)
  end

  if a.even?
    return jacobi(2, n) * jacobi(a / 2, n)
  elsif a % n != a
    return jacobi(a % n, n)
  else
    if a % 4 == n % 4 && a % 4 == 3
      return -1 * jacobi(n, a)
    else
      return jacobi(n, a)
    end
  end
end

if __FILE__ == $0
  print 'Enter prime to test: '
  p = gets.chomp.to_i
  print 'Enter certainty threshold: '
  c = gets.chomp.to_f
  if fermat(p, c)
    puts "#{p} is prime at #{c * 100}% certainty"
  else
    puts "#{p} is not prime"
  end
end
  