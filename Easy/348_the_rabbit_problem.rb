# Daily Programmer - 348 - Easy - The Rabbit Problem

# Description

# Rabbits are known for their fast breeding, but how soon will they
# dominate the earth?

# Starting with a small population of male and female rabbits we
# have to figure out how long it will take for them to outnumber humans 2:1.

# Every month a fertile female will have 14 offspring (5 males and 9 females).

# A female rabbit is fertile when it has reached the age of 4 months,
# they never stop being fertile.

# Rabbits die at the age of 8 years (96 months).

# Input description

# You will be given a list of numbers as following:

# Male_rabbits Female_rabbits Rabbits_needed_alive
# The initial rabbits will always be 2 months old and fertile females will
# always produce 14 offspring (5 male, 9 female)

# Every month that passes things should be done in this order:

# Fertile female reproduce (so 7 year & 11 months old will reproduce)
# rabbits age (except newborn) (and rabbits reaching 8 years will die, the
# 7 year & 11 months old will die)
# fx:

# 2 4 1000000000
# Output description

# You output how many months it took for world domination

# Example

# Looking just at the female population

# we start with 1 female with the given starting age of 2 months

# the index is their age (0-index is 0 months old)
# [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0] Month 0
# [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0] Month 1
# [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0] Month 2
# [ 9, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0] Month 3
# [ 9, 9, 0, 0, 0, 0, 1, 0, 0, 0, 0] Month 4
# [ 9, 9, 9, 0, 0, 0, 0, 1, 0, 0, 0] Month 5
# [ 9, 9, 9, 9, 0, 0, 0, 0, 1, 0, 0] Month 6
# [ 9, 9, 9, 9, 9, 0, 0, 0, 0, 1, 0] Month 7
# [90, 9, 9, 9, 9, 9, 0, 0, 0, 0, 1] Month 8
# For Inspiration

# The rabbit problem

# Challenge input(s)

# 2 4 1000000000

# 2 4 15000000000

# Challenge output(s)

# 32

# 36

# Bonus

# Tell how many dead rabbits there are when they dominate earth

def rabbit_problem(male, female, total)
  rabbits = Array.new(96, [0,0]).insert(2, [male, female])
  months_and_dead = [0, 0]
  while rabbits.first(96).flatten.sum < total
    fertile_fem = rabbits.select.with_index { |n, i| i > 3 && i < 96 }.map { |r| r[1] }.sum
    rabbits.unshift([5 * fertile_fem, 9 * fertile_fem])
    months_and_dead[0] += 1
  end
  months_and_dead[1] += rabbits.reject.with_index { |m, i| i < 96 }.flatten.sum
  months_and_dead
end

if __FILE__ == $0
  challenge1 = rabbit_problem(2, 4, 1000000000)
  challenge2 = rabbit_problem(2, 4, 15000000000)
  puts "#{challenge1[0]} months to domination with #{challenge1[1]} dead rabbits"
  puts "#{challenge2[0]} months to domination with #{challenge2[1]} dead rabbits"

  tot = 1000000000
  tot *= 10 until rabbit_problem(2, 4, tot)[1] > 0
  bonus = rabbit_problem(2, 4, tot)
  puts "#{bonus[0]} months until #{bonus[1]} dead rabbits appear"
end
