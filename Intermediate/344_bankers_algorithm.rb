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
    @resources = BProcess.new([0, 0, 0, 0, 0, 0], 'RESOURCE')
    @processes = []
    @combinations = []
    @valid_schedules = []
    read_data
    find_combinations
    alloc_resources
    map_valid_schedules
    print_output
  end

  def read_data
    i = 0
    DATA.each_line do |line|
      l = line.split(/\s+/).map(&:to_i)
      @resources.maxm = l if l.size < 5
      next unless l.size > 3
      @processes << BProcess.new(l, i)
      i += 1
    end
  end

  def find_combinations
    @combinations = @processes.permutation(@processes.size).to_a
    @combinations.map! { |list| [list, @resources.maxm.dup] }
  end

  def alloc_resources
    @combinations.each do |list|
      list[0].each do |process|
        invalid = ->(n) { process.maxm[n] - process.allocation[n] > list[1][n] }
        add = ->(n) { list[1][n] += process.allocation[n] }
        list << 'mark' if invalid[0] || invalid[1] || invalid[2]
        add[0] && add[1] && add[2]
      end
    end
  end

  def map_valid_schedules
    @combinations.delete_if { |list| list.size > 2 }
    @combinations.each { |list| @valid_schedules << list[0].map(&:order) }
    @valid_schedules.map! { |list| list.map! { |p| "P#{p}" } }
  end

  def print_output
    puts 'No complete valid schedules available' if @valid_schedules.empty?
    @valid_schedules.each { |sch| puts sch.join(', ') }
  end
end

class BProcess
  attr_accessor :allocation, :maxm, :order, :curr
  def initialize(array, order = nil)
    @allocation = array[0..2]
    @maxm = array[3..5]
    @order = order
  end
end

Scheduler.new

__END__
3 3 2
0 1 0 7 5 3
2 0 0 3 2 2
3 0 2 9 0 2
2 1 1 2 2 2
0 0 2 4 3 3