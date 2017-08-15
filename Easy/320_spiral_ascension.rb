# Creates a 'spiral ascension' matrix
# when initialized with a number
class Spiral
  attr_accessor :matrix
  def initialize(number)
    @num = number
    @matrix = []
    @num.times { @matrix << [] }
    @matrix.each { |line| @num.times { line << 'x' } }
    @storage_array = (@num**2).downto(1).to_a
    create
  end

  def display
    field = @matrix.flatten.map { |i| i.to_s.size }.max
    @matrix.each do |row|
      puts row.map { |i| ' ' * (field - i.to_s.size) + i.to_s }.join('  ')
    end
  end

  private

  def create
    # t=top, r=right, b=bottom, etc.
    location = 'top'
    row = 0
    col = 0
    while @storage_array.empty?
      if location == 'top'
        if @matrix[row][col] == 'x'
          @matrix[row][col] = @storage_array.pop
          col += 1 unless !@matrix[row].include?('x')
        else
          location = 'right'
          row += 1
        end
      elsif location == 'right'
        if @matrix[row][col] == 'x'
          @matrix[row][col] = @storage_array.pop
          row += 1 unless row >= @matrix.length-1
        else
          location = 'bottom'
          row = col
          col -= 1
        end
      elsif location == 'bottom'
        if @matrix[row][col] == 'x'
          @matrix[row][col] = @storage_array.pop
          col -= 1 unless !@matrix[row].include?('x')
        else
          location = 'left'
          row -= 1
        end
      elsif location == 'left'
        if @matrix[row][col] == 'x'
          @matrix[row][col] = @storage_array.pop
          row -= 1
        else
          location = 'top'
          row += 1
          col = row
        end
      end
    end
  end
end
