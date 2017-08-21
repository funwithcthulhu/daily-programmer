def countdown(string)
  final = []
  ans = []
  str_array = []
  num_array = string.split(' ').map(&:to_i)
  target = num_array.pop
  perm_array = num_array.permutation(num_array.size).to_a
  op_array = %i[+ - / *].repeated_permutation(num_array.size - 1).to_a
  perms = perm_array.dup
  until perms.empty?
    l = 0
    ops = op_array.dup
    until ops.empty?
      i = 0
      str_array.push(perms[l] + ops[i])
      ops.delete(ops[i])
      i += 1
    end
    perms.delete(perms[l])
    l += 1
  end
  str_array.map { |array| array.join(' ') }.each do |string|
    if RPNCalculator.new.evaluate(string) == target
      ans.push(RPNCalculator.new.tokens(string))
    end
  end
  ans.each do |array|
    a1 = array.select { |num| num.is_a? Integer }
    a2 = array.select { |val| val.is_a? Symbol }
    final.push(a1.zip(a2))
  end
  final.each do |arr|
    puts "#{arr.flatten.compact.join(' ')} = #{target}"
  end
end

# calculator object for adding left to right
class RPNCalculator
  attr_accessor :stack
  def initialize(stack = [])
    @stack = stack
  end

  def plus
    raise 'calculator is empty' if @stack.count < 2
    first = @stack.shift
    second = @stack.shift
    added = first + second
    @stack.unshift(added)
  end

  def minus
    raise 'calculator is empty' if @stack.count < 2
    first = @stack.shift
    second = @stack.shift
    subtracted = first - second
    @stack.unshift(subtracted)
  end

  def divide
    raise 'calculator is empty' if @stack.count < 2
    first = @stack.shift
    second = @stack.shift
    divided = first.to_f / second.to_f
    @stack.unshift(divided)
  end

  def times
    raise 'calculator is empty' if @stack.count < 2
    first = @stack.shift
    second = @stack.shift
    multiplied = first.to_f * second.to_f
    @stack.unshift(multiplied)
  end

  def tokens(string)
    string.split(' ').each do |value|
      case value
      when '*' then @stack.push(:*)
      when '/' then @stack.push(:/)
      when '+' then @stack.push(:+)
      when '-' then @stack.push(:-)
      else @stack.push(value.to_i)
      end
    end
    @stack
  end

  def evaluate(string)
    @stack = []
    string.split(' ').each do |value|
      case value
      when '*' then times
      when '/' then divide
      when '+' then plus
      when '-' then minus
      else @stack.push(value.to_i)
      end
    end
    string.include?('/') ? @stack.join.to_f : @stack.join.to_i
  end
end

# example
countdown('1 3 7 6 8 3 250')

# challenges
countdown('25 100 9 7 3 7 881')
countdown('6 75 3 25 50 100 952')
