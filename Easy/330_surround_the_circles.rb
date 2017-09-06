# draws a square around input circle coordinates
class Square
  attr_reader :item

  def initialize
    @min_x = 0
    @min_y = 0
    @max_x = 0
    @max_y = 0
    @circles = []
    circles
    process
    output
  end

  def output
    print "(#{'%.3f' % @min_x}, #{'%.3f' % @min_y}),"
    print " (#{'%.3f' % @min_x}, #{'%.3f' % @max_y}),\n"
    print "(#{'%.3f' % @max_x} #{'%.3f' % @max_y}),"
    print " (#{'%.3f' % @max_x}, #{'%.3f' % @min_y})\n"
  end

  private

  def circles
    puts "Enter 'x,y,radius', then hit return"
    puts 'Press return on empty line to finish'
    loop do
      print '> '
      @input = gets.chomp
      break if @input == ''
      @circles << @input.split(',') if check_input
      @circles.map! { |sub_arr| sub_arr.map!(&:to_f) } if check_input
    end
  end

  def check_input
    check = @input.split(',')
    check.map!(&:to_f)
    check.size == 3 ? true : false
  end

  def process
    until @circles.empty?
      each_circle
      coordinates
    end
  end

  def each_circle
    @item = @circles.shift
    @x = item[0]
    @y = item[1]
    @r = item[2]
  end

  def coordinates
    @min_x = @x - @r if @x - @r < @min_x
    @min_y = @y - @r if @y - @r < @min_y
    @max_x = @x + @r if @x + @r > @max_x
    @max_y = @y + @r if @y + @r > @min_x
  end
end
