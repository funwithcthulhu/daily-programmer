# Creates a 'spiral ascension' matrix
# when initialized with a number
class Spiral
  attr_reader :matrix
  def initialize(number)
    @location = 'top'
    @row = 0
    @col = 0
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
    until @storage_array.empty?
      case @location
      when 'top' then location_top
      when 'right' then location_right
      when 'bottom' then location_bottom
      when 'left' then location_left
      end
    end
  end

  def location_top
    if @matrix[@row][@col] == 'x'
      @matrix[@row][@col] = @storage_array.pop
      @col += 1 if @matrix[@row].include?('x')
    else
      @location = 'right'
      @row += 1
    end
  end

  def location_right
    if @matrix[@row][@col] == 'x'
      @matrix[@row][@col] = @storage_array.pop
      @row += 1 unless @row >= @matrix.length - 1
    else
      @location = 'bottom'
      @row = @col
      @col -= 1
    end
  end

  def location_bottom
    if @matrix[@row][@col] == 'x'
      @matrix[@row][@col] = @storage_array.pop
      @col -= 1 if @matrix[@row].include?('x')
    else
      @location = 'left'
      @row -= 1
    end
  end

  def location_left
    if @matrix[@row][@col] == 'x'
      @matrix[@row][@col] = @storage_array.pop
      @row -= 1
    else
      @location = 'top'
      @row += 1
      @col = @row
    end
  end
end
