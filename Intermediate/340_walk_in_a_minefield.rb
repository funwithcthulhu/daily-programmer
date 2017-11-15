# Daily Programmer Challenge 340 Intermediate
# Walk in a Minefield

# November 15, 2017

# Description

# You must remotely send a sequence of orders to a robot to get
# it out of a minefield.

# You win the game when the order sequence allows the robot to get
# out of the minefield without touching any mine. Otherwise it returns
# the position of the mine that destroyed it.

# A mine field is a grid, consisting of ASCII characters like the following:

# +++++++++++++
# +000000000000
# +0000000*000+
# +00000000000+
# +00000000*00+
# +00000000000+
# M00000000000+
# +++++++++++++

# The mines are represented by * and the robot by M.
# The orders understandable by the robot are as follows:

# N moves the robot one square to the north
# S moves the robot one square to the south
# E moves the robot one square to the east
# O moves the robot one square to the west
# I start the the engine of the robot
# - cuts the engine of the robot

# If one tries to move it to a square occupied by a wall +, then the
# robot stays in place.

# If the robot is not started (I) then the commands are inoperative.
# It is possible to stop it or to start it as many times as desired
# (but once enough).

# When the robot has reached the exit, it is necessary to stop it to
# win the game.

# The challenge

# Write a program asking the user to enter a minefield and then asks
# to enter a sequence of commands to guide the robot through the field.

# It displays after won or lost depending on the input command string.

# Input

# The mine field in the form of a string of characters, newline separated.

# Output

# Displays the mine field on the screen
# +++++++++++
# +0000000000
# +000000*00+
# +000000000+
# +000*00*00+
# +000000000+
# M000*00000+
# +++++++++++

# Input

# Commands like:

# IENENNNNEEEEEEEE-

# Output

# Display the path the robot took and indicate if it was successful or
# not. Your program needs to evaluate if the route successfully avoided
# mines and both started and stopped at the right positions.

class Field
  attr_reader :mx, :my, :ex, :ey
  attr_accessor :field
  def initialize
    @field = []
    get_field
    get_commands
    find_exit
    find_machine
    @machine = Machine.new(@mx, @my, @field)
    move
  end

  def move
    @commands.each do |command|
      @machine.on = true if command == 'I'
      next unless @machine.on
      @machine.move(command)
      @machine.explosion?
      @field[@machine.i][@machine.j] = 'M'
      transition
      display
      lost?
      won?
    end
  end

  def get_field
    puts 'Enter field, one row at a time.'
    puts 'Press return on empty line to finish'
    while (line = gets.chomp) != ''
      @field << line.split(//)
    end
  end

  def get_commands
    print 'Enter commands: '
    @commands = gets.chomp.upcase.chars
  end

  def find_machine
    raise 'No Machine found' unless @field.any? { |row| row.find { |x| x == 'M'}}
    @field.each do |row|
      row.each do |char|
        if char == 'M'
          @mx = @field.index(row)
          @my = row.index(char)
        end
      end
    end
  end

  def find_exit
    raise 'No Exit Found' unless @field.any? { |row| row.last == '0'}
    @field.each do |row|
      if row.last == '0'
        @ex = @field.index(row)
        @ey = row.size - 1
      end
    end
  end

  def display
    puts "\e[H\e[2J"
    @field.each do |row|
      puts row.join
    end
  end

  def transition
    screen = "\rmoving"
    5.times do
      print screen += '.'
      sleep(0.1)
    end
    print "\n"
  end  

  def lost?
    if @machine.dead
      puts "\e[H\e[2J"
      puts "You stepped on a mine at [#{@machine.dx}, #{@machine.dy}]!"
      puts "You've died. Goodbye"
      exit(0)
    end
  end

  def won?
    if @machine.i == @ex && @machine.j == @ey && !@machine.on
      puts "\e[H\e[2J"
      puts "You've won! Congratulations!"
      exit(0)
    end
  end
end

class Machine
  attr_reader :field, :dx, :dy
  attr_accessor :on, :dead, :i, :j

  def initialize(mx, my, field)
    @field = field
    @i = mx
    @j = my
    @on = false
    @dead = false
  end

  def move(input)
    case input
    when 'N' then north
    when 'S' then south
    when 'E' then east
    when 'O' then west
    when '-' then @on = false
    end
  end

  def start_machine
    @on = true
  end

  def north
    @i -= 1 unless @field[i - 1] == '+'
  end

  def south
    @i += 1 unless @field[i - 1] == '+'
  end

  def east
    @j += 1 unless @field[i - 1] == '+'
  end

  def west
    @j -= 1 unless @field[i - 1] == '+'
  end

  def explosion?
    if @field[@i][@j] == '*'
      @dead = true
      @dx = @i
      @dy = @j
    end
  end
end

Field.new
