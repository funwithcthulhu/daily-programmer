# Daily Programmer Challenge 340 [Easy]
# First Recurring Character
# November 13, 2017

# Description:
# Write a program that outputs the first recurring character
# in a string.

# Input Description
# A string of alphabetical characters. Example:
# ABCDEBC

# Output description
# The first recurring character from the input. From the above example:
# B

# Challenge Input
# IKEUNFUVFV
# PXLJOUDJVZGQHLBHGXIW
# *l1J?)yn%R[}9~1"=k7]9;0[$

# Bonus:
# Return the index (0 or 1 based, but please specify) where the
# original character is found in the string.

def recurring(string)
  cache = Hash.new(0)
  string.split(//).each do |l|
    cache[l] += 1
    if cache[l] > 1
      puts "#{l} index: #{string.split(//).index(l)}"
      break
    end
  end
end

example = 'ABCDEBC'
challenge1 = 'IKEUNFUVFV'
challenge2 = 'PXLJOUDJVZGQHLBHGXIW'
challenge3 = '*l1J?)yn%R[}9~1"=k7]9;0[$'
