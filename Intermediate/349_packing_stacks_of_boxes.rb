=begin
  Description
You run a moving truck business, and you can pack the most in your truck when you have stacks of equal size - no slack space. So, you're an enterprising person, and you want to write some code to help you along.

Input Description
You'll be given two numbers per line. The first number is the number of stacks of boxes to yield. The second is a list of boxes, one integer per size, to pack.

Example:

3 34312332
That says "make three stacks of boxes with sizes 3, 4, 3, 1 etc".

Output Description
Your program should emit the stack of boxes as a series of integers, one stack per line. From the above example:

331
322
34
If you can't make equal sized stacks, your program should emit nothing.

Challenge Input
3 912743471352
3 42137586
9 2 
4 064876318535318
Challenge Output
9124
7342
7135

426
138
75

(nothing)

0665
4733
8315
881
=end

require 'active_support/all'

def stack(input, n)
  array, time = input.split(//).map(&:to_i), Time.now
  loop do
    break if Time.now > time + 5
    v = array.shuffle!.in_groups(n, false)
    return v if v.all? { |x| v[0].sum == x.sum }
  end
  nil
end

stack('912743471352', 3)
stack('42137586', 3)
stack('2', 9)
stack('064876318535318', 4)

# user     system      total        real
# [[4, 7, 1, 4], [1, 7, 5, 3], [2, 2, 3, 9]]
#  0.004726   0.001628   0.006354 (  0.008831)
# [[3, 2, 7], [6, 5, 1], [8, 4]]
#  0.001271   0.000110   0.001381 (  0.001887)
# [[0, 8, 8, 1], [3, 5, 6, 3], [7, 5, 4, 1], [6, 3, 8]]
#  0.001726   0.000138   0.001864 (  0.001895)
# nil
#  4.980030   0.009184   4.989214 (  5.000092)