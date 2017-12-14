#!/Users/thomasboeding/.rubies/ruby-2.4.2/bin/ruby
# frozen_string_literal: true

'''
Description:

Create a program that will solve the banker’s algorithm. This
algorithm stops deadlocks from happening by not allowing processes
to start if they don’t have access to the resources necessary to finish.
A process is allocated certain resources from the start, and there are
other available resources. In order for the process to end, it has to
have the maximum resources in each slot.

Ex:
Process	Allocation	Max	Available
A B C	A B C	A B C
P0	0 1 0	7 5 3	3 3 2
P1	2 0 0	3 2 2	
P2	3 0 2	9 0 2	
P3	2 1 1	2 2 2	
P4	0 0 2	4 3 3	

Since there is 3, 3, 2 available, P1 or P3 would be able to go first.
Let’s pick P1 for the example. Next, P1 will release the resources that
it held, so the next available would be 5, 3, 2.

The Challenge:

Create a program that will read a text file with the banker’s algorithm
in it, and output the order that the processes should go in. An example
of a text file would be like this:

[3 3 2]
[0 1 0 7 5 3]
[2 0 0 3 2 2]
[3 0 2 9 0 2]
[2 1 1 2 2 2]
[0 0 2 4 3 3]

And the program would print out:
P1, P4, P3, P0, P2
Bonus:

Have the program tell you if there is no way to complete the algorithm.
'''

# Brute force implementation of banker's algorithm
class Scheduler
  def initialize
    @start = nil
    @schedules = []
    read_data
    make_schedules
    mark_invalid_schedules
    print_valid_schedules
  end

  def read_data
    i = 0
    DATA.each_line do |line|
      l = line.split(/\s+/).map(&:to_i)
      @start = l if i.zero?
      @schedules << BProcess.new(l, i) if i > 0
      i += 1
    end
  end

  def make_schedules
    @schedules = @schedules.permutation(@schedules.size).to_a
    @schedules.map! { |list| [list, @start.dup] }
  end

  def mark_invalid_schedules
    @schedules.each do |list|
      list[0].each do |process|
        process.maxavail.size.times do |i|
          list << 'mark' if process.maxavail[i] - process.allocation[i] > list[1][i]
          list[1][i] += process.allocation[i]
        end
      end
    end
  end

  def print_valid_schedules
    @schedules.delete_if { |list| list.size > 2 }
    puts 'No complete valid schedules available' if @schedules.empty?
    @schedules.map! { |list| list[0].map! { |p| "P#{p.order}" } }
    @schedules.each { |sch| puts sch.join(', ') }
  end
end

# Process object
class BProcess
  attr_accessor :allocation, :maxavail, :order, :curr
  def initialize(array, order = nil)
    size = array.size / 2
    @allocation = array[0..(size - 1)]
    @maxavail = array[size..(size * 2)]
    @order = order
  end
end

Scheduler.new

__END__
6 5 2 6 7
0 2 0 7 5 3 2 3 1 5
2 1 0 3 2 2 1 7 1 0
3 0 2 9 0 5 5 3 4 1
2 4 1 2 4 2 5 3 2 3
0 0 2 4 3 3 4 4 5 4
2 4 1 7 4 8 1 1 4 0