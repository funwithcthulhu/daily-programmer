def countdown(string)
  num_array = string.split(' ').map(&:to_i)
  target = num_array.pop
  size = num_array.size
  operators = [:+, :-, :/, :*]
  perm_array = num_array.permutation(size).to_a
  op_array = operators.repeated_permutation(size-1).to_a
  $str_array = []
  ans = []
  perms = perm_array.dup
  while perms.length > 0
    l = 0
    p_temp = perms[l]
    ops = op_array.dup
    while ops.length > 0
      i = 0
      op_temp = ops[i]
      $str_array.push(perms[l]+op_temp)
      ops.delete(ops[i])
      i += 1
    end
    perms.delete(perms[l])
    l += 1
  end
  $str_array.map! { |array| array.join(' ') }
  $str_array.each do |string|
    puts string if RPNCalculator.new.evaluate(string) == target
    ans.push(string) if RPNCalculator.new.evaluate(string) == target
  end
  working = []
  ans.each do |string|
    working.push(RPNCalculator.new.tokens(string))
  end
  final = []
  working.each do |array|
    a1 = array.select { |num| num.is_a? Integer}
    a2 = array.select { |val| val.is_a? Symbol }
    final.push(a1.zip(a2))
  end
  final.each do |arr|
    puts "#{arr.flatten.compact.join(' ')} = #{target}"
  end
end

class RPNCalculator
  attr_accessor :stack
  def initialize(stack = [])
    @stack = stack
  end

  def plus
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.shift
      second_to_last = @stack.shift
      added = last + second_to_last
      @stack.unshift added
    end
  end

  def minus
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.shift
      second_to_last = @stack.shift
      subtracted = last - second_to_last
      @stack.unshift subtracted
    end
  end

  def divide
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.shift
      second_to_last = @stack.shift
      divided =  last.to_f / second_to_last.to_f
      @stack.unshift divided
    end
  end

  def times
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.shift
      second_to_last = @stack.shift
      multiplied = last.to_f * second_to_last.to_f
      @stack.unshift multiplied
    end
  end

  def tokens(string)
    string.split(' ').each do |value|
      case
      when value == "*"
        @stack.push(:*)
      when value == "/"
        @stack.push(:/)
      when value == "+"
        @stack.push(:+)
      when value == "-"
        @stack.push(:-)
      else
        @stack.push value.to_i
      end
    end
    @stack
  end

  def evaluate(string)
    @stack = []
    string.split(' ').each do |value|
      case
      when value == "*"
        times
      when value == "/"
        divide
      when value == "+"
        plus
      when value == "-"
        minus
      else
        @stack.push value.to_i
      end
    end
    (string.include? '/') ? (@stack.join.to_f) : (@stack.join.to_i)
  end
end

#example
countdown('1 3 7 6 8 3 250')

#challenges
countdown('25 100 9 7 3 7 881')
countdown('6 75 3 25 50 100 952')
