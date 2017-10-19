class Cube
  attr_accessor :cube
  def cube
    cube = 
      {
        U: ['B', 'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B'],
        D: ['G', 'G', 'G', 'G', 'G', 'G', 'G', 'G', 'G'],
        L: ['W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W'],
        R: ['Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y'],
        F: ['R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R'],
        B: ['O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O']
      }
  end
end

class Rubiks
  def initialize
    @cube = Cube.new.cube
  end

  def sequence
    @count = 0
    print 'Enter sequence: '
    sequence = gets.chomp.upcase.split(/\s+/)
    until @cube == Cube.new.cube && @count > 0
      sequence.each do |m|
        t = m.split(//)
        if t.size == 2 && t[1] == "'"
          move(t[0].to_sym, 3)
        elsif t.size == 2 && t[1].to_i != 0
          move(t[0].to_sym, t[1].to_i)
        else
          move(m.to_sym)
        end
      end
      @count += 1
    end
    puts "Returned to origin state in #{@count} executions of sequence"
  end

  def move(side, times = 1)
    case side
    when :U
      clockwise_main(:U, times)
      clockwise_adjacents(:B, :L, :F, :R, 0, 1, 2, times)
    when :D
      clockwise_main(:D, times)
      clockwise_adjacents(:F, :L, :B, :R, 6, 7, 8, times)
    when :L
      clockwise_main(:L, times)
      left_adjacents(:U, :B, :D, :F, times)
    when :R
      clockwise_main(:R, times)
      right_adjacents(:U, :F, :D, :B, times)
    when :F
      clockwise_main(:F, times)
      front_adjacents(:U, :L, :D, :R, times)
    when :B
      clockwise_main(:B, times)
      back_adjacents(:U, :R, :D, :L, times)
    end
  end

  private

  def clockwise_main(side, x = 1)
    x.times do
      a = @cube[side][6]
      b = @cube[side][3]
      c = @cube[side][0]
      d = @cube[side][7]
      e = @cube[side][1]
      f = @cube[side][8]
      g = @cube[side][5]
      h = @cube[side][2]
      @cube[side][0] = a
      @cube[side][1] = b
      @cube[side][2] = c
      @cube[side][3] = d
      @cube[side][5] = e
      @cube[side][6] = f
      @cube[side][7] = g
      @cube[side][8] = h
    end
  end

  def clockwise_adjacents(side1, side2, side3, side4, w, y, z, x = 1)
    x.times do
      a, b, c = @cube[side1][w], @cube[side1][y], @cube[side1][z]
      @cube[side1][w], @cube[side1][y], @cube[side1][z] = @cube[side2][w], @cube[side2][y], @cube[side2][z]
      @cube[side2][w], @cube[side2][y], @cube[side2][z] = @cube[side3][w], @cube[side3][y], @cube[side3][z]
      @cube[side3][w], @cube[side3][y], @cube[side3][z] = @cube[side4][w], @cube[side4][y], @cube[side4][z]
      @cube[side4][w], @cube[side4][y], @cube[side4][z] = a, b, c
    end
  end

  def front_adjacents(side1, side2, side3, side4, x = 1)
    x.times do
      a, b, c = @cube[side1][6], @cube[side1][7], @cube[side1][8]
      @cube[side1][6], @cube[side1][7], @cube[side1][8] = @cube[side2][8], @cube[side2][5], @cube[side2][2]
      @cube[side2][2], @cube[side2][5], @cube[side2][8] = @cube[side3][0], @cube[side3][1], @cube[side3][2]
      @cube[side3][0], @cube[side3][1], @cube[side3][2] = @cube[side4][6], @cube[side4][3], @cube[side4][0]
      @cube[side4][0], @cube[side4][3], @cube[side4][6] = a, b, c
    end
  end

  def back_adjacents(side1, side2, side3, side4, x = 1)
    x.times do
      a, b, c = @cube[side1][0], @cube[side1][1], @cube[side1][2]
      @cube[side1][0], @cube[side1][1], @cube[side1][2] = @cube[side2][2], @cube[side2][5], @cube[side2][8]
      @cube[side2][2], @cube[side2][5], @cube[side2][8] = @cube[side3][8], @cube[side3][7], @cube[side3][6]
      @cube[side3][8], @cube[side3][7], @cube[side3][6] = @cube[side4][6], @cube[side4][3], @cube[side4][0]
      @cube[side4][6], @cube[side4][3], @cube[side4][0] = a, b, c
    end
  end

  def right_adjacents(side1, side2, side3, side4, x = 1)
    x.times do
      a, b, c = @cube[side1][2], @cube[side1][5], @cube[side1][8]
      @cube[side1][2], @cube[side1][5], @cube[side1][8] = @cube[side2][2], @cube[side2][5], @cube[side2][8]
      @cube[side2][2], @cube[side2][5], @cube[side2][8] = @cube[side3][2], @cube[side3][5], @cube[side3][8]
      @cube[side3][2], @cube[side3][5], @cube[side3][8] = @cube[side4][6], @cube[side4][3], @cube[side4][0]
      @cube[side4][6], @cube[side4][3], @cube[side4][0] = a, b, c
    end
  end

  def left_adjacents(side1, side2, side3, side4, x = 1)
    x.times do
      a, b, c = @cube[side1][0], @cube[side1][3], @cube[side1][6]
      @cube[side1][0], @cube[side1][3], @cube[side1][6] = @cube[side2][8], @cube[side2][5], @cube[side2][2]
      @cube[side2][2], @cube[side2][5], @cube[side2][8] = @cube[side3][6], @cube[side3][3], @cube[side3][0]
      @cube[side3][6], @cube[side3][3], @cube[side3][0] = @cube[side4][6], @cube[side4][3], @cube[side4][0]
      @cube[side4][0], @cube[side4][3], @cube[side4][6] = a, b, c
    end
  end
end

challenge336 = Rubiks.new
challenge336.sequence
