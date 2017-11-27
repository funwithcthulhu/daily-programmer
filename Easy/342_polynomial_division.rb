#!/Users/thomasboeding/.rubies/ruby-2.4.2/bin/ruby

# Daily Programmer #342 Easy - Polynomial Division
# November 27, 2017

# Description

# Today's challenge is to divide two polynomials. For example,
# long division can be implemented.

# Display the quotient and remainder obtained upon division.

# Input Description

# Let the user enter two polynomials. Feel free to accept it
# as you wish to. Divide the second polynomial by the first.
# For the sake of clarity, I'm writing whole expressions in
# the challenge input, but by all means, feel free to accept
# the degree and all the coefficients of a polynomial.

# Output Description

# Display the remainder and quotient obtained.

# Challenge Input

# 1:
# 4x^3 + 2x^2 - 6x + 3
# x - 3
# 2:
# 2x^4 - 9x^3 + 21x^2 - 26x + 12
# 2x - 3
# 3:
# 10x^4 - 7x^2 -1
# x^2 - x + 3

# Challenge Output

# 1:
# Quotient: 4x^2 + 14x + 36 Remainder: 111
# 2:
# Quotient: x^3 - 3x^2 +6x - 4 Remainder: 0
# 3:
# Quotient: 10x^2 + 10x - 27 Remainder: -57x + 80

# Bonus

# Go for long division and display the whole process,
# like one would on pen and paper.

require 'wolfram-alpha'

response = (WolframAlpha::Client.new "8WPKPK-KQ4THTLGKQ").query(ARGV[0])
result = response.find { |pod| pod.title == "Quotient and remainder" }
puts result.subpods[0].plaintext
