def countdown(*nums)
  calculator = RPNCalculator.new
  numbers = nums.to_a
  target = numbers.pop
  permutations = numbers.permutation(numbers.length).to_a.uniq!
  operators = ['+', '-','*', '/']
  permutations.each do |sub_array|
      sub_array.map!(&:to_s)
      sub_array.insert(1, operators.sample)
      sub_array.insert(3, operators.sample)
      sub_array.insert(5, operators.sample)
      sub_array.insert(7, operators.sample)
      sub_array.insert(9, operators.sample)
      p sub_array.join('')
      p calculator.evaluate(sub_array.join(''))
      if calculator.evaluate(sub_array.join('')) == target 
        print "#{sub_array.join(' ')} = #{target}"
      end
  end
end

class RPNCalculator
  attr_accessor :stack
  def initialize(stack = [])
    @stack = stack
  end

  def push(nums)
    @stack.push nums
  end
  
  def plus
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.pop
      second_to_last = @stack.pop
      added = last + second_to_last
      @stack.push added
    end
  end
  
  def minus
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.pop
      second_to_last = @stack.pop
      subtracted = second_to_last - last
      @stack.push subtracted
    end
  end
  
  def divide
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.pop
      second_to_last = @stack.pop
      divided = second_to_last.to_f / last.to_f
      @stack.push divided
    end
  end
  
  def times
    if @stack.count < 2
      raise "calculator is empty"
    else
      last = @stack.pop
      second_to_last = @stack.pop
      multiplied = second_to_last.to_f * last.to_f
      @stack.push multiplied
    end
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
  
  def value
    @stack.last
  end
end
  
countdown(1, 3, 7, 6, 8, 3, 250)
