example = '''O G
B O R O Y
O R B G R
B O G O Y 
Y G B Y G 
R O R B R'''

challenge = '''R O Y P O
R R B R R R B P Y G P B B B G P B P P R
B G Y P R P Y Y O R Y P P Y Y R R R P P
B P G R O P Y G R Y Y G P O R Y P B O O
R B B O R P Y O O Y R P B R G R B G P G
R P Y G G G P Y P Y O G B O R Y P B Y O
O R B G B Y B P G R P Y R O G Y G Y R P
B G O O O G B B R O Y Y Y Y P B Y Y G G
P P G B O P Y G B R O G B G R O Y R B R
Y Y P P R B Y B P O O G P Y R P P Y R Y
P O O B B B G O Y G O P B G Y R R Y R B
P P Y R B O O R O R Y B G B G O O P B Y
B B R G Y G P Y G P R R P Y G O O Y R R
O G R Y B P Y O P B R Y B G P G O O B P
R Y G P G G O R Y O O G R G P P Y P B G
P Y P R O O R O Y R P O R Y P Y B B Y R
O Y P G R P R G P O B B R B O B Y Y B P
B Y Y P O Y O Y O R B R G G Y G R G Y G
Y B Y Y G B R R O B O P P O B O R R R P
P O O O P Y G G Y P O G P O B G P R P B
R B B R R R R B B B Y O B G P G G O O Y'''

# Transforms the color-maze string into a nested array
# when an instance of Maze is created. The 'solve' method
# solves the maze from top to bottom according to the key.
# 'Path' re-writes the maze replacing letters not on
# the solve-path with '/', and 'display' prints the maze
# to the screen.
class Maze
  def initialize(input)
    @maze = input.split("\n").map { |str| str.delete(' ') }.map do |str|
      str.split('')
    end
    @key = @maze.shift
    @path_seq = []
    @row = 0
    @col = 0
  end

  def display
    @maze.each { |row| puts row.join(' ') }
  end

  def path
    @maze.each_with_index do |row, row_index|
      row.each_index do |col_index|
        if @path_seq.include?([row_index, col_index])
          @maze[row_index][col_index]
        else
          @maze[row_index][col_index] = '/'
        end
      end
    end
  end

  def solve
    while @row < @maze.size - 1
      @temp1 = @maze[@row + 1][@col]
      @temp2 = @maze[@row][@col - 1]
      @temp3 = @maze[@row][@col + 1]
      @key.include?(@maze[@row][@col]) ? find_seq : @col += 1 
    end
    @path_seq << [@row, @col]
  end

  private

  def find_seq
    if @key.include?(@temp1)
      down
    elsif @key.include?(@temp2) && !@path_seq.include?([@row, @col])
      left
    elsif @key.include?(@temp3)
      right
    elsif !@key.include?(@temp1) && !@key.include?(@temp2) && !@key.include?(@temp3) && !@row.zero?
      backtrack
    else
      seq_clear
    end
  end

  def seq_clear
    @path_seq.clear
    @col += 1
  end

  def down
    @path_seq << [@row, @col]
    @row += 1
  end

  def right
    @path_seq << [@row, @col]
    @col += 1
  end

  def left
    @path_seq << [@row, @col]
    @col -= 1 unless @col.zero?
  end

  def backtrack
    @maze[@row][@col] = '/'
    @row -= 1 unless @maze[@row - 1][@col].nil?
  end
end
