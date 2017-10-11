# program for scoring a cribbage hand
class Cribbage
  DICT =
    {
      'A' => ' 1 ',
      'J' => ' 10 ',
      'Q' => ' 10 ',
      'K' => ' 10 ',
      'D' => ' D ',
      'S' => ' S ',
      'C' => ' C ',
      'H' => ' H '
    }.freeze

  RUN = { 'A' => 1, 'J' => 11, 'Q' => 12, 'K' => 13 }.freeze

  def initialize
    input_loop
  end

  def input_loop
    puts 'Input hand separated by commas: '
    puts 'ex: 5D,QS,JC,KH,AC '
    puts 'Hit return on empty line to exit program'
    loop do
      print 'Hand > '
      @input = gets.chomp
      break if @input == ''
      parse_input
      score
    end
  end

  def parse_input
    @raw = @input.gsub(/[AJQKDSCH]/, DICT).delete(',').split(' ')
    @suits = [@raw[1], @raw[3], @raw[5], @raw[7], @raw[9]]
    @cards = [@raw[0], @raw[2], @raw[4], @raw[6], @raw[8]].map(&:to_i)
  end

  def score
    @score = 0
    fifteen?
    runs?
    pairs?
    flush?
    @score += 1 if nobs?
    puts "Score: #{@score}"
  end

  def fifteen?
    z = 1
    while z < 6
      @cards.combination(z).to_a.each do |arr|
        @score += 2 if arr.inject(:+) == 15
      end
      z += 1
    end
  end

  def runs?
    @runs = @input.gsub(/[AJQKDSCH]/, RUN).split(',').map(&:to_i)
    if five_run?
      @score += 5
    elsif four_run?
      @score += 4
    elsif three_run?
      @score += 3
    end
  end

  def three_run?
    @runs.sort.each_cons(3).any? do |a, b, c|
      c == a + 2 && b == a + 1
    end
  end

  def four_run?
    @runs.sort.each_cons(4).any? do |a, b, c, d|
      c == a + 2 && b == a + 1 && d == a + 3
    end
  end

  def five_run?
    @runs.sort.each_cons(5).any? do |a, b, c, d, e|
      c == a + 2 && b == a + 1 && d == a + 3 && e == a + 4
    end
  end

  def pairs?
    pairs = @input.split(',')
    pairs.each do |card|
      case pairs.count(card)
      when 2 then @score += 1
      when 3 then @score += 2
      when 4 then @score += 3
      end
    end
  end

  def flush?
    if @suits.uniq.size == 1
      @score += 5
    else
      temp = @suits.pop
      @score += 4 if @suits.uniq.size == 1
      @suits.push(temp)
    end
  end

  def nobs?
    return false unless @input.include?('J')
    comp = @input.split(',').pop
    temp = @input.split(',').delete_if { |a| !a.include?('J') }
    return false unless comp.split(//).last == temp.join.split(//).last
    true
  end
end
