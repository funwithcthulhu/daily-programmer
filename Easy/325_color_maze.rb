example = """O G
B O R O Y
O R B G R
B O G O Y 
Y G B Y G 
R O R B R"""

class Maze 
  def initialize(input)
    @maze = input.split("\n").map {|str| str.delete(" ")}.map do |str|
      str.split('')
    end
    @key = @maze.shift
    p @key
    p @maze
  end

  def solve
    seq = []
    row = 0
    col = 0
    size = @maze.size - 1
    while seq.size <= size
      temp = @maze[row][col]
      temp1 = @maze[row+1][col]
      temp2 = @maze[row+1][col-1]
      temp3 = @maze[row+1][col+1]
      if @key.include?(temp)
        if row < size && (@key.include?(temp1) || @key.include?(temp2) || @key.include?(temp3))
          seq << [row, col]
          row += 1 unless @maze[row][col+1] == nil
        else 
          seq << [row,col]
          break
        end
      else
        col += 1 unless @maze[row][col+1] == nil
      end 
    end
    p seq
  end
end
