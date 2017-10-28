# r/dailyprogrammer Problem 313 -- Easy

# Given a sorted list of distinct integers, write a function
# that returns whether there are two integers in the list that
# add up to 0. For example, you would return true if both -14435
# and 14435 are in the list, because -14435 + 14435 = 0. Also return
# true if 0 appears in the list.
#

# Works for challenge (k = 2)
def ssum(arr); arr.any? { |b| arr.any? { |x| (b+x).zero? }}; end

# should return true
bonus = [-98634, -86888, -48841, -40483, 2612, 9225, 17848, 71967, 84319, 88875]

# below should return false
bonus2 = [-83314, -82838, -80120, -63468, -62478, -59378, -56958, -50061, -34791, -32264, -21928, -14988, 23767, 24417, 26403, 26511, 36399, 78055]
bonus3 = [-92953, -91613, -89733, -50673, -16067, -9172, 8852, 30883, 46690, 46968, 56772, 58703, 59150, 78476, 84413, 90106, 94777, 95148]
bonus4 = [-94624, -86776, -85833, -80822, -71902, -54562, -38638, -26483, -20207, -1290, 12414, 12627, 19509, 30894, 32505, 46825, 50321, 69294]
bonus5 = [-83964, -81834, -78386, -70497, -69357, -61867, -49127, -47916, -38361, -35772, -29803, -15343, 6918, 19662, 44614, 66049, 93789, 95405]
bonus6 = [-68808, -58968, -45958, -36013, -32810, -28726, -13488, 3986, 26342, 29245, 30686, 47966, 58352, 68610, 74533, 77939, 80520, 87195]

# below should return true
bonus7 = [-97162, -95761, -94672, -87254, -57207, -22163, -20207, -1753, 11646, 13652, 14572, 30580, 52502, 64282, 74896, 83730, 89889, 92200]
bonus8 = [-93976, -93807, -64604, -59939, -44394, -36454, -34635, -16483, 267, 3245, 8031, 10622, 44815, 46829, 61689, 65756, 69220, 70121]
bonus9 = [-92474, -61685, -55348, -42019, -35902, -7815, -5579, 4490, 14778, 19399, 34202, 46624, 55800, 57719, 60260, 71511, 75665, 82754]
bonus10 = [-85029, -84549, -82646, -80493, -73373, -57478, -56711, -42456, -38923, -29277, -3685, -3164, 26863, 29890, 37187, 46607, 69300, 84808]
bonus11 = [-87565, -71009, -49312, -47554, -27197, 905, 2839, 8657, 14622, 32217, 35567, 38470, 46885, 59236, 64704, 82944, 86902, 90487]

# Seems to work for bonus input (above)
def subset_sum(array)
  (1..array.size).each do |k|  
    array.combination(k).to_a.each(&:sort!).uniq.each do |sub_array|
      return [true, k, sub_array] if sub_array.inject(&:+).zero?
    end
  end
  false
end

# Output:
# irb(main):118:0> subset_sum(bonus)
# => [true, 10, [-98634, -86888, -48841, -40483, 2612, 9225, 17848, 71967, 84319, 88875]]
# irb(main):119:0> subset_sum(bonus2)
# => false
# irb(main):120:0> subset_sum(bonus3)
# => false
# irb(main):121:0> subset_sum(bonus4)
# => false
# irb(main):122:0> subset_sum(bonus5)
# => false
# irb(main):123:0> subset_sum(bonus6)
# => false
# irb(main):124:0> subset_sum(bonus7)
# => [true, 7, [-97162, -95761, -22163, 14572, 52502, 64282, 83730]]
# irb(main):125:0> subset_sum(bonus8)
# => [true, 12, [-93807, -64604, -59939, -44394, -36454, 267, 10622, 44815, 46829, 61689, 65756, 69220]]
# irb(main):126:0> subset_sum(bonus9)
# => [true, 8, [-92474, -42019, -35902, -7815, 14778, 34202, 57719, 71511]]
# irb(main):127:0> subset_sum(bonus10)
# => [true, 8, [-84549, -57478, -42456, -3685, 26863, 29890, 46607, 84808]]
# irb(main):128:0> subset_sum(bonus11)
# => [true, 7, [-87565, -49312, 905, 2839, 14622, 35567, 82944]]
