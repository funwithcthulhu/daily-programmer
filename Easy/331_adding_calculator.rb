class AddingCalculator
  def initialize
    input_loop
  end

  def input_loop
    loop do
      print '> '
      @input = gets.chomp
      check_input
    end
  end

  def check_input
    @arr = @input.split(' ')
    @a = @arr[0].to_i
    @b = @arr[2].to_i
    @operator = @arr[1]
    evaluate
  end

  def evaluate
    case @operator
    when '*' then puts multiply(@a, @b)
    when '/' then puts divide(@a, @b)
    when '+' then puts @a + @b
    when '-' then puts subtract(@a, @b)
    when '^' then puts exponent(@a, @b)
    end
    @input = ''
  end

  def multiply(a, b)
    working_a = a
    working_b = b
    neg = false
    working_b = b.abs if b < 0
    working_a = a.abs if a < 0
    neg = true if a > 0 && b < 0
    neg = true if b > 0 && a < 0
    c = 0
    working_b.times { c += working_a }
    neg ? "-#{c}".to_i : c
  end

  def exponent(a, b)
    return 1 if b.zero?
    return 'Not-defined' if a.zero? && b < 0
    return 0 if a.zero?
    return 'Non-integral answer' if b < 0
    neg = false
    if a < 0
      neg = true
      a = a.abs
    end
    count = 0
    c = 1
    until count == b
      c = multiply(a, c)
      count += 1
    end
    neg ? "-#{c}".to_i : c
  end

  def subtract(a, b)
    negative = false
    return 0 if a.zero? && b.zero?
    return a if b.zero?
    if a.zero?
      return "-#{b}".to_i if b > 0
      return b.abs if b < 0
    end
    if a < 0 && b > 0
      return "-#{a.abs + b}".to_i
    elsif a < 0 && b < 0
      a = a.abs
      b = b.abs
      negative = true
    elsif a > 0 && b < 0
      return a + b.abs
    end
    count = 0
    temp = b
    until temp == a
      temp += 1
      count += 1
    end
    count = "-#{count}".to_i if negative
    count
  end

  def divide(a, b)
    temp_a = a
    negative = false
    return 'Not-defined' if b.zero?
    return 0 if temp_a.zero?
    return 1 if temp_a == b
    return temp_a if b == 1
    if temp_a < 0 && b < 0
      temp_a = temp_a.abs
      b = b.abs
    elsif temp_a < 0 && b > 0
      negative = true
      temp_a = temp_a.abs
    elsif b < 0 && temp_a > 0
      negative = true
      b = b.abs
    end
    return 'Non-integral answer' if temp_a < b
    count = 0
    c = 0
    until c >= temp_a
      c += b
      count += 1
    end
    count = "-#{count}".to_i if negative
    c == temp_a ? count : 'Non-integral answer'
  end
end
