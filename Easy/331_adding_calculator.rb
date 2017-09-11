# dailyprogrammer 331: adding calculator. Requires rubinius 3.84
class AddingCalculator
  def initialize
    input_loop
  end

  private

  NEG_VAL = Fixnum::MIN + 4_611_686_018_427_387_902

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
  end

  def make_neg(a)
    multiply(a, NEG_VAL)
  end

  def subtract(a, b)
    c = make_neg(b)
    a + c
  end

  def multiply(a, b)
    c = 0
    if a < 0 && b > 0
      b.times { c += a }
    elsif b < 0 && a > 0
      a.times { c += b }
    else
      a.abs.times { c += b.abs }
    end
    c
  end

  def exponent(a, b)
    return 'Non-integral answer' if b < 0
    count = 0
    c = 1
    until count == b
      c = multiply(a, c)
      count += 1
    end
    c
  end

  def divide(a, b)
    return 'Not-defined' if b.zero?
    negative = true if a ^ b < 0
    a, b = a.abs, b.abs
    count = 0
    c = 0
    until c >= a
      c += b
      count += 1
    end
    count = make_neg(count) if negative
    c == a ? count : 'Non-integral answer'
  end
end
