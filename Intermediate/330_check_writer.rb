require 'bigdecimal'
# Main converter methods for Float class
module FloatConverter
  def write_check
    first = self.to_i
    dec_place = self.to_s.split('.').last.to_i
    first = convert(first)
    second = convert(dec_place.to_i)
    second = 'zero' if second == ''
    (first + ' dollars' + ' and ' + second + ' cents').capitalize
  end

  def convert(int)
    return '' if int.zero?
    DICT.each do |i, words|
      return words.to_s if int.to_s.length == 1 && int / i > 0
      if int < 100 && int / i > 0
        return words.to_s if (int % i).zero?
        return "#{words}-" + (int % i).write_check
      elsif int / i > 0
        return (int / i).write_check + " #{words} " + (int % i).write_check
      end
    end
  end

  DICT =
    {
      1_000_000_000_000_000_000 => 'quintillion',
      1_000_000_000_000_000 => 'quadrillion',
      1_000_000_000_000 => 'trillion',
      1_000_000_000 => 'billion',
      1_000_000 => 'million',
      1000 => 'thousand',
      100 => 'hundred',
      90 => 'ninety',
      80 => 'eighty',
      70 => 'seventy',
      60 => 'sixty',
      50 => 'fifty',
      40 => 'forty',
      30 => 'thirty',
      20 => 'twenty',
      19 => 'nineteen',
      18 => 'eighteen',
      17 => 'seventeen',
      16 => 'sixteen',
      15 => 'fifteen',
      14 => 'fourteen',
      13 => 'thirteen',
      12 => 'twelve',
      11 => 'eleven',
      10 => 'ten',
      9 => 'nine',
      8 => 'eight',
      7 => 'seven',
      6 => 'six',
      5 => 'five',
      4 => 'four',
      3 => 'three',
      2 => 'two',
      1 => 'one'
    }.freeze
end

# The write_check method needs to be simpler for the Integer class
module IntConverter
  def write_check
    num = self
    convert(num)
  end
end

# Including the appropriate Float module in class Float
class Float
  include FloatConverter
end

# Including the appropriate modules in class Integer
class Integer
  include FloatConverter
  include IntConverter
end
