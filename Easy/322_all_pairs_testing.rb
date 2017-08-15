input = [['0', '1'], ['A', 'B', 'C'], ['D', 'E', 'F', 'G']]

input.first.product(*input[1..-1]).map(&:join)

input.inject(&:product).map(&:flatten)

input.inject(&:product).map do |array|
  array.map do |sub_array|
    sub_array.uniq
  end
end