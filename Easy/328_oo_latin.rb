# Checks if initialized matrix is a Latin Square
class Latin
  def initialize
    @dups = []
    puts 'Enter length of array'
    print '> '
    @length = gets.chomp.to_i
    puts 'Enter n x n numbers, each separated by a space'
    print '> '
    @numbers = gets.chomp
    build_matrix
    latin_square?
  end

  def latin_square?
    check_row
    check_col
    puts @dups.empty? ? true : false
  end

  private

  def build_matrix
    @matrix = @numbers.split(' ').map!(&:to_i)
    rows = @matrix.length / @length
    rows.times do
      temp = @matrix.slice!(0...@length)
      @matrix << temp
    end
  end

  def check_row
    @matrix.each do |col|
      @dups = col.select { |num| col.count(num) > 1 }
    end
  end

  def check_col
    @matrix.transpose.each do |col|
      @dups = col.select { |num| col.count(num) > 1 }
    end
  end
end
