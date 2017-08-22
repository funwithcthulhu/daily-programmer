# Checks if initialized matrix is a Latin Square,
# if matrix is a Latin Square, reduces the matrix
# if possible, and displays it to the screen
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
    output
  end

  def output
    if latin_square?
      puts "\nMatrix is a Latin Square. Reducing now..."
      puts ''
      @matrix.sort_by! { |row| row[0] }
      display
      puts "\nLatin Square Reduced"
    else
      puts "\nMatrix is not a Latin Square"
    end
  end

  def latin_square?
    check_row
    check_col
    check_include
    check_count
    @dups.empty? ? true : false
  end

  def display
    field = @matrix.flatten.map { |i| i.to_s.size }.max
    @matrix.each do |row|
      puts row.map { |i| ' ' * (field - i.to_s.size) + i.to_s }.join('  ')
    end
  end

  def check_row
    @matrix.each do |row|
      @dups = row.select { |num| row.count(num) > 1 }
    end
  end

  def check_col
    @matrix.transpose.each do |col|
      @dups = col.select { |num| col.count(num) > 1 }
    end
  end

  def check_include
    @matrix.each do |row|
      row.each do |int|
        @dups.push(1) if !@matrix[0].include?(int)
      end
    end
  end

  def check_count
    @matrix.each do |row|
      @dups.push(1) if row.count != @matrix[0].count
    end
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
end
