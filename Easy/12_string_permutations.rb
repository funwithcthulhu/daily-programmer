# Implementation of Heap's algorithm
# to find all permutations of a string without
# using the built-in "permutation" method
def perm(str, n = str.size - 1)
  puts str if n == 0
  (n + 1).times do |i|
    perm(str, n - 1)
    if n.even?
      str[1], str[n] = str[n], str[1]
    else
      str[i], str[n] = str[n], str[i]
    end
  end
end
